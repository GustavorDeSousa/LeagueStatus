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
    var lastDTO: [LastMatchDTO?] = []
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        REST.loadLastMatch(accountId: "eGQ_c89pY38pUTqXum1wQZDAnwGDTP_f7_bVcF28Qumi",
                           onComplete: { (onComplete) in
                            self.lastDTO = onComplete
                            
                            
        }) { (onError) in
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableMatch.dequeueReusableCell(withIdentifier: "MatchTableViewCell") as! MatchTableViewCell
        cell.imgChampion.downloaded(from: "https://ddragon.leagueoflegends.com/cdn/9.16.1/img/champion/Kayle.png")
        cell.lblChampion.text = "Você é um DEUS"
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
