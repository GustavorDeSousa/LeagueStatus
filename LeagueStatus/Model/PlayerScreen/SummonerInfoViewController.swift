//
//  SummonerInfoViewController.swift
//  LeagueStatus
//
//  Created by Gustavo De Sousa on 26/08/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class SummonerInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblSummonerName: UILabel!
    @IBOutlet weak var lblSummonerLevel: UILabel!
    @IBOutlet weak var imgSummonerIcon: UIImageView!
    @IBOutlet weak var tableMatch: UITableView!
    
    var viewModel: PlayerViewModel? = PlayerViewModel()
    var lastDTO: [LastMatchDTO] = []
    var champioDTO: Champions?
    
    class func create(viewModel: PlayerViewModel) -> SummonerInfoViewController {
        let controller = SummonerInfoViewController(nibName: "SummonerInfoViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgSummonerIcon.layer.cornerRadius = imgSummonerIcon.frame.height / 2
        
        self.tableMatch.delegate = self
        self.tableMatch.dataSource = self
        tableMatch.register(UINib(nibName: "MatchTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchTableViewCell")
        
        if let vm = viewModel {
            lblSummonerName.text = vm.getPlayer().name
            lblSummonerLevel.text = String(vm.getPlayer().summonerLevel)
            imgSummonerIcon.downloaded(from: MapURL.ICON_PLAYER + String(vm.getPlayer().profileIconId) + ".png")
        }
        loadMatch()
        loadChampions()
    }
    
    func loadChampions() {
        //Recuperando o Json
        let fileURL = Bundle.main.url(forResource: "data.json", withExtension: nil)!
        let jsonData = try! Data(contentsOf: fileURL)
        do {
            champioDTO = try JSONDecoder().decode(Champions.self, from: jsonData)
            guard let champ = champioDTO else { return }
            viewModel?.setListChamppion(champpion: champ)
            DispatchQueue.main.async {
                self.tableMatch.reloadData()
            }
        }catch{
            print(error)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    func loadMatch() {
        REST.loadLastMatch(accountId: viewModel?.getPlayer().accountId ?? "",
                           onComplete: { (onComplete) in
                            self.viewModel?.setLastMatch(lastMatch: onComplete)
                            DispatchQueue.main.async {
                                self.tableMatch.reloadData()
                            }
                            
        }) { (onError) in
            //FAZER ALERTA
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableMatch.dequeueReusableCell(withIdentifier: "MatchTableViewCell") as! MatchTableViewCell
        guard let vm = viewModel else { return UITableViewCell() }
        if viewModel?.getLastMatch().count != 0 {
            for championId in (vm.getListChamppion().data) {
                if Int(championId.key) == vm.lastMatchDTO?[0].matches[indexPath.row].champion {
                    cell.imgChampion.downloaded(from: MapURL.BASEURLIMG_V2 + championId.image.full)
                    cell.lblChampion.text = championId.name
                }
            }
        } else {
            return UITableViewCell()
        }
        return cell
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
