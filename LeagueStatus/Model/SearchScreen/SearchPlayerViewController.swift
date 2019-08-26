//
//  SearchPlayerViewController.swift
//  LeagueOfLegndsAPI
//
//  Created by Gustavo De Sousa on 22/08/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class SearchPlayerViewController: UIViewController {

    @IBOutlet weak var txtPlayer: UITextField!
    
    private var viewModel = PlayerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func searchPlayer(_ sender: Any) {
        REST.loadPlayer(name: txtPlayer.text!, onComplete: { (onComplete) in
            self.viewModel.setPlayer(player: onComplete)
            print(self.viewModel.getPlayer().name)
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(SummonerInfoViewController.create(viewModel: self.viewModel), animated: true)
            }
        }) { (onError) in
            
        }
        
    }
}
