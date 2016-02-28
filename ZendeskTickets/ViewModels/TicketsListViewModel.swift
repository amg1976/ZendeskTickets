//
//  TicketsListViewModel.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import Foundation


class TicketsListViewModel {
   
   private var tickets: [Ticket]
   private var cellViewModels: [TicketsListCellViewModel]
   var cellIdentifier: String { return TicketsListCollectionViewCell.identifier }
   
   let collectionViewNumberOfSections: Int = 1
   
   init(tickets: [Ticket]) {
      self.tickets = tickets
      self.cellViewModels = []
   }
   
   func collectionViewNumberOfItems(section: Int) -> Int {
      return tickets.count
   }
   
   func cellViewModelAt(indexPath: NSIndexPath) -> TicketsListCellViewModel? {
      guard cellViewModels.count > indexPath.item else { return nil }
      
      return cellViewModels[indexPath.item]
   }
   
}