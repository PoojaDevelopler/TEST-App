//
//  HomeView.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit

class HomeView: UIViewController {

    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        configuartion()
    }

}


extension HomeView{
    
    func configuartion(){
        initalViewModel()
        observeEvent()
    }
    
    func initalViewModel(){
        viewModel.fetchMediaList()
    }
    
    //dataBinding
    func observeEvent(){
        
        viewModel.updates = { [weak self] event in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async{
                
                switch event {
                    
                case .loading:
                    print("errorMsg")
                    
                case .stopLoading:
                    print("errorMsg")
                    
                case .CustomError(let errorMsg):
                    print(errorMsg)
                    
                }
            }
        }
    }
    
}

extension HomeView{
    
}
