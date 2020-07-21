//
//  Extension.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit
extension UIDevice{
    func isIPAD() -> Bool{
        if UIDevice.current.userInterfaceIdiom == .pad {
           return true
        }
        return false
    }
    
}

extension UICollectionViewCell{
    class var reuseIdentifier:String{
        return "\(self)"
    }
}

extension UITableViewCell{
    class var reuseIdentifier:String{
        return "\(self)"
    }
}
