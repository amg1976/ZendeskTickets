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
   
   var description: String { return ticket.description }
   var backgroundColor: UIColor { return UIColor.orangeColor() }
   
   init(ticket: Ticket) {
      self.ticket = ticket
   }
   
}