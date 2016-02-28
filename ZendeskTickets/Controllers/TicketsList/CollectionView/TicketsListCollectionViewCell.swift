//
//  TicketsListCollectionViewCell.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class TicketsListCollectionViewCell: UICollectionViewCell {
 
   static var identifier: String { return String(self) }
   
   private var cellModel: TicketsListCellViewModel?
   private var descriptionLabel: UILabel?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      let descriptionLabel = UILabel(frame: CGRect.zero)
      descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(descriptionLabel)
      
      let dictViews = ["label":descriptionLabel]
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[label]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[label]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      
      self.descriptionLabel = descriptionLabel
   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   func update(cellModel: TicketsListCellViewModel) {
      self.cellModel = cellModel
      contentView.backgroundColor = cellModel.backgroundColor
      descriptionLabel?.text = cellModel.description
   }
   
}
