//
//  FactsTableViewCell.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {
let padding:CGFloat = 8
    
    class var CellSize:CGSize{
        
        var width = UIScreen.main.bounds.width - 40
        if UIDevice.current.isIPAD(){
            width = width/2
        }
        return CGSize(width: width, height: 300)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var factTitle:UILabel!
    private var factDesc:UILabel!
    private var factImage:UIImageView!
    
    
    var title:UILabel{
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 1
        label.textColor = UIColor.black
        return label
    }
    
    var desc:UILabel{
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        return label
    }

    var imageV:UIImageView{
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    
    func setupUI()  {
        factTitle = title
                factDesc = desc
                factImage = imageV
                
                factTitle.translatesAutoresizingMaskIntoConstraints = false
                factDesc.translatesAutoresizingMaskIntoConstraints = false
                factImage.translatesAutoresizingMaskIntoConstraints = false
                self.contentView.addSubview(factTitle)
                self.contentView.addSubview(factDesc)
                self.contentView.addSubview(factImage)
                
                
                NSLayoutConstraint.activate([
                    self.factImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                    self.factImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    self.factImage.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: padding),
                    self.factImage.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -padding),
                    self.factImage.widthAnchor.constraint(equalToConstant: FactsTableViewCell.CellSize.width),
        //            self.factImage.heightAnchor.constraint(lessThanOrEqualToConstant: 220),
                    self.factTitle.topAnchor.constraint(greaterThanOrEqualTo: factImage.bottomAnchor, constant: padding),
                    self.factTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    self.factTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                    self.factTitle.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
                    self.factDesc.topAnchor.constraint(equalTo: factTitle.bottomAnchor, constant: padding),
                    self.factDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding ),
                    self.factDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                    self.factDesc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
                    self.factDesc.heightAnchor.constraint(lessThanOrEqualToConstant: 60)
                ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*func configure(_ viewModel:RowViewModel){
        factImage.image = viewModel.image
        factTitle.text = viewModel.title
        factDesc.text = viewModel.desc
    }*/
    
}
