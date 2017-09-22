//
//  NetworkServiceTests.swift
//  ZendeskTicketTests
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import XCTest

class NetworkServiceTests: XCTestCase {
    
    func testCanGetTickets() {
        
        let expectation = self.expectation(description: "test if network service is working")
        
        let service = ZendeskApiService()
        
        service.getTickets { (tickets, error) -> Void in
            XCTAssertNil(error)
            if let tickets = tickets {
                XCTAssertGreaterThan(tickets.count, 0)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60.0, handler: nil)
        
    }
    
}
