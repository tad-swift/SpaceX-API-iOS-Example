//
//  Network.swift
//  SpaceX API iOS Example
//
//  Created by Tadreik Campbell on 9/28/22.
//

import Foundation


class Network {
    
    
    func getData(completion: @escaping ([DataObject], Error?) -> Void) {
        let request = URLRequest(url: URL(string: "https://api.spacexdata.com/v3/launches")!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion([], error)
                return
            }
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {
                        completion([], nil)
                        return
                    }
                    var objects: [DataObject] = []
                    print(json.first)
                    for object in json {
                        
                        let links = object["links"] as! [String: Any]
                        let missionPatch = links["mission_patch"] as? String
                        let imageURL = URL(string: missionPatch ?? "")
                        let launchSite = object["launch_site"] as! [String: Any]
                        let rocket = object["rocket"] as! [String: Any]
                        let rocketName = rocket["rocket_name"] as! String
                        let newDataObject = DataObject(
                            missionName: object["mission_name"] as! String,
                            rocketName: rocketName,
                            launchSite: LaunchSite(siteName: launchSite["site_name_long"] as? String),
                            launchDate: object["launch_date_unix"] as! Int,
                            launchPatchImage: imageURL)
                        objects.append(newDataObject)
                    }
                    completion(objects, nil)
                } catch {
                    completion([], error)
                }
                return
            }
        }.resume()
    }
    
}
