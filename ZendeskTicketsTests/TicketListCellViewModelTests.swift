//
//  TicketListCellViewModelTests.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import XCTest

class TicketListCellViewModelTests: XCTestCase {
  
   func testCanCreateCellViewModelFromTicket() {
   
      let ticket = Ticket(dictionary: ["subject":"This is a subject","id":1,"status":"new"])
      let cellViewModel = TicketsListCellViewModel(ticket: ticket!)
      XCTAssertEqual(cellViewModel.description, ticket!.description)
      
   }
    
}
