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
   
   var subject: NSAttributedString
   var description: NSAttributedString
   var numberAndStatus: NSAttributedString

   var backgroundColor: UIColor { return UIColor(red: 120/255, green: 163/255, blue: 0, alpha: 1) }
   var textColor: UIColor { return UIColor.whiteColor() }
   
   init(ticket: Ticket) {
      self.ticket = ticket
      
      let paragraph = NSMutableParagraphStyle()
      paragraph.alignment = NSTextAlignment.Right
      self.numberAndStatus = NSAttributedString(string: "#\(ticket.number) - \(ticket.status.rawValue.uppercaseString)", attributes: [NSParagraphStyleAttributeName:paragraph])
      
      self.subject = NSAttributedString(string: ticket.subject, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(20, weight: UIFontWeightBold)])

      self.description = NSAttributedString(string: ticket.description, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(20, weight: UIFontWeightRegular)])

   }
   
}