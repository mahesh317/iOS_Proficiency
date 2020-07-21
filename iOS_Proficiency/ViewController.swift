//
//  ViewController.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {


    var factViewModel = FactsViewModel()
    var imageDownloaders = Set<ImageDownloader>()
    var refreshControl:UIRefreshControl!

    var tableView = UITableView()
    override func loadView() {
        super.loadView()
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
       refreshControl = UIRefreshControl()
        self.setupTableView()
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
                tableView.insetsLayoutMarginsFromSafeArea = true
                tableView.backgroundColor = UIColor.white
                view.addSubview(tableView)
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:0).isActive = true
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
                tableView.dataSource = factViewModel.getDatasource()
                tableView.delegate = self
                tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: FactsTableViewCell.reuseIdentifier)
                
                refreshControl.addTarget(self, action: #selector(retryClicked), for: .valueChanged)
                
                tableView.addSubview(refreshControl)
                
                view.layoutIfNeeded()
            }
            
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tableView.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }

    func bindUI()  {
        factViewModel.title.bind { [weak self](name) in
            if let titlename = name{
                DispatchQueue.main.async {
                    self?.title = titlename
                }
            }
        }
        
        factViewModel.error.bind { [weak self] (error) in
            if let error = error{
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    self?.showAlert(forError: error)
                }
            }
        }
        
        factViewModel.reloadView.bind { (success) in
            if success{
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    @objc func retryClicked(){
        factViewModel.getFactsDataSource()
    }
    func showAlert(forError error:Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { (action) in
            self.retryClicked()
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let url = factViewModel.getImageUrl(indexPath){
            // fetch from already cache image
            if let imageDownloader = imageDownloaders.filter({ $0.imageUrl == url && $0.imageCache != nil}).first{
                if self.factViewModel.updateRowImage(imageDownloader.imageCache, row: indexPath.row){
                    DispatchQueue.main.async{
                        self.tableView.reloadRows(at: [indexPath], with: .none)
                    }
                }
            }else{
                // fetch new imageim
                let downloader = ImageDownloader.init(url) { (image) in
                    if self.factViewModel.updateRowImage(image, row: indexPath.row){
                        DispatchQueue.main.async {
                            self.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    }
                }
                imageDownloaders.insert(downloader)
            }
        }
    }

}

