//
//  DataPipe.swift
//  NewspaperExample
//
//  Created by Séverin FERARD on 16/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import SwiftSoup


class DataPipe {
    
    let userID: String
    let userPWD: String
    let root_URL = "https://franceprotectioncivile.org/"
    let events_URL = "https://franceprotectioncivile.org/evenement_choice.php"
    let session = URLSession.shared
    var semaphore: DispatchSemaphore
    
    init(userID: String, userPWD: String) {
        self.userID = userID
        self.userPWD = userPWD
        self.semaphore = DispatchSemaphore(value: 0)
    }
    
    func GetDataFromURL(url: String) -> String{
        if let url = URL(string: url) {
            do {
                let contents = try String(contentsOf: url, encoding: .ascii)
                return contents
            } catch {
                return "some shit :  \(error)"
                // contents could not be loaded
            }
        } else {
            return "error"
            // the URL was bad!
        }
    }
    
    
    func GetEvents() -> Array<Event> {
        var events = [Element]()
        print("started getevents")
        var res = [Event]()
        do {
            
            var rawHTML = GetDataFromURL(url: self.events_URL)
            var doc: Document = try SwiftSoup.parse(rawHTML)
            var rows: Elements = try doc.select("tr")
            print("before log", rows.count)
            
            if (rows.count < 1) {
                self.semaphore = DispatchSemaphore(value: 0)
                let url = URL(string: "https://franceprotectioncivile.org/check_login.php")
                guard let requestUrl = url else { fatalError() }
                var request = URLRequest(url: requestUrl)
                request.httpMethod = "POST"
                 
                let postString = "id=\(userID)&pwd=\(userPWD)";
                request.httpBody = postString.data(using: String.Encoding.utf8);
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                    if let error = error {
                        print("Error took place \(error)")
                    }
                    if let data = data, let _ = String(data: data, encoding: .utf8) {
                            print("finished login")
                            self.semaphore.signal()
                    }
                }
                task.resume()
                semaphore.wait()
                print("after semaphore")
            }
            rawHTML = GetDataFromURL(url: self.events_URL)
            doc = try SwiftSoup.parse(rawHTML)
            rows = try doc.select("tr")
            print("after log", rows.count)
            
            for row in rows {
                if try row.attr("onclick").contains("redirect") {
                    events.append(row)
                }
            }
            for e in events{
                let onclickAttr = try e.attr("onclick")
                let keyIndex = onclickAttr.range(of: #"[0-9]{6}"#, options: .regularExpression)
                let currentEventObject = Event(name: try e.select("td")[0].text() ,
                                               date: try e.select("td")[2].text() ,
                                               time: try e.select("td")[3].text() ,
                                               eventNumber: String(onclickAttr[keyIndex!]) ,
                                               type:  try e.select("img").attr("title")
                    )!
                
                res.append(currentEventObject)
            }

  
                } catch Exception.Error(let type, let message) {
                    print("ERROR CATCHED")
                    print(type, message)
                } catch {
                    print("error")
                }
            
        
        return res
    }
    
    
    
}
