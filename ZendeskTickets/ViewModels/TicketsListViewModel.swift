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
    var viewBackgroundColor: UIColor { return .white }
    var collectionViewBackgroundColor: UIColor { return .clear }
    
    init(apiService: ZendeskApiService) {
        self.apiService = apiService
    }
    
    func getTickets(onCompletion completion: @escaping ((NSError?) -> Void)) {
        apiService.getTickets { (tickets, error) -> Void in
            if let tickets = tickets {
                self.cellViewModels = self.convertTicketsToCellViewModel(tickets)
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    func collectionViewNumberOfItems(inSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TicketsListCellViewModel? {
        guard cellViewModels.count > indexPath.item else { return nil }
        
        return cellViewModels[indexPath.item]
    }
}

extension TicketsListViewModel {
    
    func convertTicketsToCellViewModel(_ tickets: [Ticket]) -> [TicketsListCellViewModel] {
        return tickets.map { return TicketsListCellViewModel(ticket: $0) }
    }
    
}
