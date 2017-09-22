//
//  TicketsListCellViewModel.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

struct TicketsListCellViewModel {
    
    private var ticket: Ticket
    
    let subject: NSAttributedString
    let description: NSAttributedString
    let numberAndStatus: NSAttributedString
    
    var backgroundColor: UIColor { return UIColor(red: 120/255, green: 163/255, blue: 0, alpha: 1) }
    var textColor: UIColor { return .white }
    
    init(ticket: Ticket) {
        self.ticket = ticket
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.right
        self.numberAndStatus = NSAttributedString(string: "#\(ticket.number) - \(ticket.status.rawValue.uppercased())", attributes: [NSAttributedStringKey.paragraphStyle:paragraph])
        
        self.subject = NSAttributedString(string: ticket.subject, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)])
        
        self.description = NSAttributedString(string: ticket.description, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)])
        
    }
    
}
