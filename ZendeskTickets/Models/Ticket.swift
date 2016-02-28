//
//  Ticket.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import Foundation

enum TicketState: String {
   case New = "new"
}

class Ticket {
   
   var description: String = ""
   var number: Int = 0
   var state: TicketState = .New
   
   init?(dictionary: [NSObject:AnyObject]) {
      guard let description = dictionary["subject"] as? String,
         number = dictionary["id"] as? Int,
         stateString = dictionary["status"] as? String,
         state = TicketState(rawValue: stateString) else { return nil }
      
      self.description = description
      self.number = number
      self.state = state
   }
   
}