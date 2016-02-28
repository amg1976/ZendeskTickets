//
//  TicketsListViewModelTests.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import XCTest

class TicketsListViewModelTests: XCTestCase {
   
   func testCanConvertTicketsToCellViewModels() {
      
      let tickets: [Ticket] = []
      let viewModel = TicketsListViewModel(apiService: ZendeskApiService())
      let cellViewModels = viewModel.convertTicketsToCellViewModel(tickets)
      XCTAssertEqual(tickets.count, cellViewModels.count)
      
   }
   
}
