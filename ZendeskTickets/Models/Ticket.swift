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
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let subject = dictionary["subject"] as? String,
            let description = dictionary["description"] as? String,
            let number = dictionary["id"] as? Int,
            let statusString = dictionary["status"] as? String,
            let status = TicketStatus(rawValue: statusString) else { return nil }
        
        self.subject = subject
        self.description = description
        self.number = number
        self.status = status
    }
    
}
