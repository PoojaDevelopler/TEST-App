//
//  HomeView.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit

class HomeView: UIViewController {

    var viewModel:HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupInitial()
    }

}


extension HomeView{
    
    func setupInitial(){
        viewModel.fetchMediaList()
    }
    
    func eventHandler(){
        viewModel.vmUpdate : { result in
            switch result {
            case <#pattern#>:
                <#code#>
            default:
                <#code#>
            }
            
        }
    }
    
    
}
