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
   
   func update(cellModel: TicketsListCellViewModel) {
      self.cellModel = cellModel
   }
   
}
