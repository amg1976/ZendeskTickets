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
        let dictionary: [String : Any] = ["subject":"This is a subject", "description":"This is a description", "id":1, "status":"new"]
        let ticket = Ticket(dictionary: dictionary)
        let cellViewModel = TicketsListCellViewModel(ticket: ticket!)
        XCTAssertEqual(cellViewModel.description.string, ticket!.description)
        XCTAssertEqual(cellViewModel.numberAndStatus.string, "#1 - NEW")
        
    }
    
}
