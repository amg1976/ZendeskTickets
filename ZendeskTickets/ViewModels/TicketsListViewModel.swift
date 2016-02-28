//
//  TicketsListViewModel.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class TicketsListViewModel {
   
   private var apiService: ZendeskApiService
   private var tickets: [Ticket] = []
   private var cellViewModels: [TicketsListCellViewModel] = []

   let collectionViewNumberOfSections: Int = 1

   var cellIdentifier: String { return TicketsListCollectionViewCell.identifier }
   var viewBackgroundColor: UIColor { return UIColor.whiteColor() }
   var collectionViewBackgroundColor: UIColor { return UIColor.clearColor() }
   
   init(apiService: ZendeskApiService) {
      self.apiService = apiService
   }

   func getTickets(onCompletion: (NSError? -> Void)) {
      apiService.getTickets { [unowned self] (tickets, error) -> Void in
         if let tickets = tickets {
            self.cellViewModels = self.convertTicketsToCellViewModel(tickets)
            onCompletion(nil)
         } else {
            onCompletion(error)
         }
      }
   }

   func collectionViewNumberOfItems(section: Int) -> Int {
      return cellViewModels.count
   }
   
   func cellViewModelAt(indexPath: NSIndexPath) -> TicketsListCellViewModel? {
      guard cellViewModels.count > indexPath.item else { return nil }
      
      return cellViewModels[indexPath.item]
   }
}

extension TicketsListViewModel {

   internal func convertTicketsToCellViewModel(tickets: [Ticket]) -> [TicketsListCellViewModel] {
      return tickets.map { return TicketsListCellViewModel(ticket: $0) }
   }

}