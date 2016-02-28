//
//  ZendeskApiService.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import Foundation

typealias ServiceResult = (tickets: [Ticket]?, error: NSError?) -> Void

class ZendeskApiService {
   
   private var urlSession: NSURLSession
   
   init(session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())) {
      urlSession = session
   }
   
   func getTickets(onCompletion: ServiceResult) {
      let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json")!)
      
      let username = "acooke+techtest@zendesk.com"
      let password = "mobile"
      let loginString = NSString(format: "%@:%@", username, password)
      let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
      let base64LoginString = loginData.base64EncodedStringWithOptions([])
      
      urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
      let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
         if let data = data {
            do {
               let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
               if let tickets = jsonObject["tickets"] as? [[NSObject:AnyObject]] {
                  var results = [Ticket]()
                  for ticketDictionary in tickets {
                     if let ticket = Ticket(dictionary: ticketDictionary) {
                        results.append(ticket)
                     }
                  }
                  onCompletion(tickets: results, error: nil)
               }
            } catch {
               onCompletion(tickets: nil, error: NSError(domain: "json", code: 1000, userInfo: [NSLocalizedDescriptionKey : "Error parsing json"]))
            }
         } else {
            onCompletion(tickets: nil, error: error)
         }
      }
      task.resume()
   }
   
}