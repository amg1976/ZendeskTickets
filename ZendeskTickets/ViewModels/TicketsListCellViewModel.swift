//
//  TicketsListCellViewModel.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class TicketsListCellViewModel {
   
   private var ticket: Ticket
   
   var subject: String { return "Subject: \(ticket.subject)" }
   var description: String { return ticket.description }
   var numberAndStatus: String { return "Ticket #\(ticket.number) - Status: \(ticket.status.rawValue.uppercaseString)" }

   var backgroundColor: UIColor { return UIColor(red: 120/255, green: 163/255, blue: 0, alpha: 1) }
   var textColor: UIColor { return UIColor.whiteColor() }
   
   init(ticket: Ticket) {
      self.ticket = ticket
   }
   
}