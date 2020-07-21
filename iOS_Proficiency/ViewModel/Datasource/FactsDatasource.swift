//
//  FactsDatasource.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit

class FactsDatasource: NSObject, UITableViewDataSource {
    
    
    
    private var rows:[RowViewModel] = []
    
    func updateRows(_ rows:[RowViewModel]){
        self.rows = rows
    }
    
    func updateRowImage(_ image:UIImage?, forRow row:Int) -> Bool{
        let item = self.rows[row]
        if item.image == UIImage(named: "placeholder"){
            item.updateImage(image)
            return true
        }
        return false
                
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: FactsTableViewCell.reuseIdentifier, for: indexPath) as! FactsTableViewCell
        cell.configure(rows[indexPath.row])
        return cell
    }
    
        
    
}
