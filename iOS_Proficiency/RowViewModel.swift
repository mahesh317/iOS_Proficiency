//
//  RowViewModel.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit
class RowViewModel {
    
    var title:String?
    var desc:String?
    var image:UIImage? = UIImage(named: "placeholder")
    
    init(_ row:Rows) {
        self.title = row.title
        self.desc = row.description
    }
    
    func updateImage(_ image:UIImage?){
        self.image = image
    }
    
}
