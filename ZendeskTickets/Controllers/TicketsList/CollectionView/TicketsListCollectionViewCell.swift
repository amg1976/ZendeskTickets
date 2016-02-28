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
   private var numberAndStatusLabel: UILabel?
   private var subjectLabel: UILabel?
   private var descriptionLabel: UILabel?
   
   override init(frame: CGRect) {
      super.init(frame: frame)

      let numberAndStatusLabel = UILabel(frame: CGRect.zero)
      numberAndStatusLabel.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(numberAndStatusLabel)

      let subjectLabel = UILabel(frame: CGRect.zero)
      subjectLabel.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(subjectLabel)

      let descriptionLabel = UILabel(frame: CGRect.zero)
      descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(descriptionLabel)
      
      let widthMargins = 2
      
      let dictViews = ["numberAndStatusLabel":numberAndStatusLabel,"subjectLabel":subjectLabel,"descriptionLabel":descriptionLabel]
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(widthMargins))-[numberAndStatusLabel]-(\(widthMargins))-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(widthMargins))-[subjectLabel]-(\(widthMargins))-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(widthMargins))-[descriptionLabel]-(\(widthMargins))-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(4)-[numberAndStatusLabel]", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[numberAndStatusLabel]-(4)-[subjectLabel]", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subjectLabel]-(4)-[descriptionLabel]-(>=4)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      
      self.numberAndStatusLabel = numberAndStatusLabel
      self.subjectLabel = subjectLabel
      self.descriptionLabel = descriptionLabel
      
      contentView.layer.cornerRadius = 2.0
      
   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   func update(cellModel: TicketsListCellViewModel) {
      self.cellModel = cellModel

      contentView.backgroundColor = cellModel.backgroundColor
      numberAndStatusLabel?.textColor = cellModel.textColor
      subjectLabel?.textColor = cellModel.textColor
      descriptionLabel?.textColor = cellModel.textColor
      
      numberAndStatusLabel?.text = cellModel.numberAndStatus
      subjectLabel?.text = cellModel.subject
      descriptionLabel?.text = cellModel.description
   }
   
}
