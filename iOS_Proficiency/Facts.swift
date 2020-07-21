//
//  Facts.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit

struct Facts:Decodable {
    var title:String
    var rows:[Rows]
}

struct Rows:Decodable {
    var title:String?
    var description:String?
    var imageHref:String?
}
