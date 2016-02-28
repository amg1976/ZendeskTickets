//
//  TicketModelTests.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import XCTest

class TicketModelTests: XCTestCase {
    
   func testCanCreateModelFromDictionary() {
   
      let validDictionary = ["subject":"This is a subject","description":"This is a description","id":1,"status":"new"]
      let validModel = Ticket(dictionary: validDictionary)
      XCTAssertNotNil(validModel)
      
   }

   func testCanCreateModelFromDictionaryWithExtraKeys() {
      
      let validDictionary = ["subject":"This is a subject","description":"This is a description","id":1,"status":"new","otherKey":"otherValue"]
      let validModel = Ticket(dictionary: validDictionary)
      XCTAssertNotNil(validModel)
      
   }

   func testCannotCreateModelFromDictionaryWithMissingKeys() {
      
      let validDictionary = ["subject":"This is a subject","id":1,"status":"new","otherKey":"otherValue"]
      let validModel = Ticket(dictionary: validDictionary)
      XCTAssertNil(validModel)
      
   }

}
