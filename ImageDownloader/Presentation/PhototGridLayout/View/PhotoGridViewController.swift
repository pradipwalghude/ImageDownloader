//
//  PhotoGridViewController.swift
//  ImageDownloader
//
//  Created by Pradip Walghude on 22/11/20.
//  Copyright © 2020 ZS Associate. All rights reserved.
//

import UIKit

class PhotoGridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchBarController: UISearchController!
    private var numberOfColumns: CGFloat = FlickrConstants.defaultColumnCount
    private var viewModel = FlickrViewModel()

    // MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModelClosures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // default search text pass = "AthenaHealth"
        viewModel.search(text: "AthenaHealth") {
           
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showAlert(title: String = "Flickr", message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func refreshTableView(){
        viewModel.search(text: searchBarController.searchBar.text ?? "") {
             self.collectionView.reloadData()
        }
    }
}

//MARK:- Configure UI
extension PhotoGridViewController {
    
    fileprivate func configureUI() {
        // Do any additional setup after loading the view, typically from a nib.
        
        createSearchBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nib: PhotoGridCollectionViewCell.nibName)
    }
}

//MARK:- Clousers
extension PhotoGridViewController {
    
    fileprivate func viewModelClosures() {
        
        viewModel.showAlert = { [weak self] (message) in
            self?.searchBarController.isActive = false
            self?.showAlert(message: message)
        }
        
        viewModel.dataUpdated = { [weak self] in
            print("data source updated")
            self?.collectionView.reloadData()
        }
    }
    
    private func loadNextPage() {
        viewModel.fetchNextPage {
            print("next page fetched")
        }
    }
}

extension PhotoGridViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        collectionView.reloadData()
        
        viewModel.search(text: text) {
            print("search completed.")
        }
        
        searchBarController.searchBar.resignFirstResponder()
    }
    
}

//MARK:- UICollectionViewDataSource
extension PhotoGridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCollectionViewCell.nibName, for: indexPath) as! PhotoGridCollectionViewCell
        cell.imageView.image = #imageLiteral(resourceName: "placeholder")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoGridCollectionViewCell else {
            return
        }
        
        let model = viewModel.photoArray[indexPath.row]
        cell.model = ImageModel.init(withPhotos: model)
        
        if indexPath.row == (viewModel.photoArray.count - 5) {
            loadNextPage()
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension PhotoGridViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (((collectionView.bounds.width)/numberOfColumns)-1), height: (collectionView.bounds.width)/numberOfColumns)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}




