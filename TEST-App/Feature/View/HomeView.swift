//
//  HomeView.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    private var activityIndicator: UIActivityIndicatorView!
    private let reuseIdentifier = CellId.MediaImageCellID.rawValue
    private var viewModel = HomeViewModel()
    private let imageLoader = ImageLoader()


    override func viewDidLoad() {
        super.viewDidLoad()
        configuartion()
    }
}


extension HomeView{
    
    private func configuartion(){
        self.title = "आचार्यप्रशान्त"
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        activityIndiactorSetup()
        configureCollectionView()
        initalViewModel()
        observeEvent()
        
    }
    
    private  func activityIndiactorSetup(){
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private  func initalViewModel(){
        self.viewModel.fetchMediaList()
    }
    
    private  func observeEvent(){
        
        viewModel.updates = { [weak self] event in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async{
                
                switch event {
                case .loading:
                    self.activityIndicator.startAnimating()
                    
                case .stopLoading:
                    self.activityIndicator.stopAnimating()
                    
                case .feacthed:
                    self.mediaCollectionView.reloadData()
                case .CustomError(let errorMsg):
                    print(errorMsg)
                    self.showAlert(message: errorMsg)
                    
                }
            }
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let itemSize = (view.frame.width - 4 * spacing) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        mediaCollectionView.collectionViewLayout = layout
        mediaCollectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension HomeView:UICollectionViewDataSource , UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mediaModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MediaImageCell
        
        guard let imageURLString = viewModel.getImageString(forIndex: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.mediaImageString = imageURLString
        return cell
    }
   
}

