//
//  FactsViewModel.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit

class FactsViewModel {
    var title :Box<String?> = Box(nil)
    var reloadView:Box<Bool> = Box(false)
    var error : Box<Error?> = Box(nil)
    var rows:[Rows] = []
    private var collectionViewDatasource = FactsDatasource()
    
    func getDatasource() -> FactsDatasource {
        return self.collectionViewDatasource
    }
    
    
    init() {
        self.getFactsDataSource()
    }
    
    // get image url
    func getImageUrl(_ indexPath:IndexPath) -> URL?{
        if indexPath.row < self.rows.count {
            if let imageHref = self.rows[indexPath.row].imageHref{
                return URL(string: imageHref)
            }
            return nil
        }
        return nil
    }
    
    
    // fetch Phots from API
    func getFactsDataSource() {
        ServiceManager.sharedInstance.getFacts { (result) in
            switch result {
            case .success(let facts):
                self.title.value = facts.title
                self.rows = facts.rows
                self.collectionViewDatasource.updateRows(self.rows.map({ RowViewModel($0)}))
                self.reloadView.value = true
            case .failure(let error): self.error.value = error
            }
        }
    }
    
    func updateRowImage(_ image:UIImage?, row:Int) -> Bool{
        return self.collectionViewDatasource.updateRowImage(image, forRow: row)
    }
}
