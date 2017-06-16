//
//  TableViewController.swift
//  alamofireTutorial
//
//  Created by Jack Ngai on 6/16/17.
//  Copyright © 2017 Jack Ngai. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    var searchURL = "https://api.spotify.com/v1/search?"
    typealias JSONStandard = [String:AnyObject]
    
    var trackNamesArray:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamo(url: searchURL)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "trackName")
    }
    
    func callAlamo(url: String){
        
        Alamofire.request(url, method: .get, parameters: ["q":"Bruno Mars", "type":"track", "offset":"20"], encoding: URLEncoding.default, headers: ["Authorization":"Bearer "]).responseJSON { (response) in
            
            if let responseData = response.data{
                self.parseData(JSONData: responseData)
            }
            
            
        }
    }


    func parseData(JSONData : Data){
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as? JSONStandard
            if let readableJSONUnwrapped = readableJSON{
                if let tracks = readableJSONUnwrapped["tracks"] as? JSONStandard{
                    print(readableJSONUnwrapped)
                    if let items = tracks["items"] {
                        
                        for i in 0..<items.count{
                            guard let item = items[i] as? JSONStandard else {
                                break
                            }
                            
                            guard let name = item["name"] as? String else {
                                break
                            }
                            trackNamesArray.append(name)
 
                           
                        }
                    }
                    
                }
                
            }
            tableView.reloadData()

        }
        catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackNamesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackName", for: indexPath) as? TableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "trackName", for: indexPath) }
        cell.trackNameLabel.text = trackNamesArray[indexPath.row]
        return cell
    }
}


