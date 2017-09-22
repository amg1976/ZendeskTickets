//
//  ZendeskApiService.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import Foundation

typealias ServiceResult = (_ tickets: [Ticket]?, _ error: Error?) -> Void

class ZendeskApiService {
    
    fileprivate var urlSession: URLSession
    
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        urlSession = session
    }
    
    func getTickets(_ onCompletion: @escaping ServiceResult) {
        let urlRequest = NSMutableURLRequest(url: URL(string: "https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json")!)
        
        let username = "acooke+techtest@zendesk.com"
        let password = "mobile"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString(options: [])
        
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let task = urlSession.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    if let tickets = jsonObject["tickets"] as? [[AnyHashable: Any]] {
                        print("apiService: got \(tickets.count) tickets from response")
                        var results = [Ticket]()
                        for ticketDictionary in tickets {
                            if let ticket = Ticket(dictionary: ticketDictionary) {
                                results.append(ticket)
                            }
                        }
                        print("apiService: created \(results.count) tickets")
                        onCompletion(results, nil)
                    }
                } catch {
                    print("apiService: error parsing json")
                    onCompletion(nil, NSError(domain: "json", code: 1000, userInfo: [NSLocalizedDescriptionKey : "Error parsing json"]))
                }
            } else {
                print("apiService: error: \(String(describing: error?.localizedDescription))")
                onCompletion(nil, error)
            }
        }
        task.resume()
    }
    
}
