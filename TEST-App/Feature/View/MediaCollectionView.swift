//
//  MediaCollectionView.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit


class MediaCollectionView: UICollectionViewController {
    
    private let reuseIdentifier =  CellId.MediaImageCellID.rawValue
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        initializeViewModel()
        observeEvents()
    }
    
}

extension MediaCollectionView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mediaModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MediaImageCell
        
        guard let imageURLString = viewModel.getImageString(forIndex: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.mediaImageString = imageURLString
        
        return cell
    }
}


extension MediaCollectionView{
    
    func configureCollectionView() {
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let spacing: CGFloat = 10
        let itemSize = (view.frame.width - 4 * spacing) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.register(MediaImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func initializeViewModel() {
        viewModel.fetchMediaList()
    }
    
    func observeEvents() {
        viewModel.updates = { [weak self] event in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    print("Loading...")
                case .stopLoading:
                    print("Loading stopped.")
                case .feacthed:
                    self.collectionView.reloadData()
                case .CustomError(let errorMsg):
                    print(errorMsg)
                }
            }
        }
    }
    
}
