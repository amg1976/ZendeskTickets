//
//  Ticket.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import Foundation

enum TicketStatus: String {
   case New = "new", Pending = "pending", Open = "open"
}

class Ticket {
   
   var subject: String = ""
   var description: String = ""
   var number: Int = 0
   var status: TicketStatus = .New
   
   init?(dictionary: [NSObject:AnyObject]) {
      guard let subject = dictionary["subject"] as? String,
         description = dictionary["description"] as? String,
         number = dictionary["id"] as? Int,
         statusString = dictionary["status"] as? String,
         status = TicketStatus(rawValue: statusString) else { return nil }
      
      self.subject = subject
      self.description = description
      self.number = number
      self.status = status
   }
   
}