//
//  Models.swift
//  SpaceX API iOS Example
//
//  Created by Tadreik Campbell on 9/28/22.
//

import Foundation

struct DataObject: Identifiable, Codable {
    
    let missionName: String?
    let rocketName: String
    let launchSite: LaunchSite
    let launchDate: Int
    let launchPatchImage: URL?
    
    var id: String {
        rocketName + String(launchDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case rocketName = "rocket_name"
        case launchSite = "launch_site"
        case launchDate = "launch_date_unix"
        case launchPatchImage = "launch_patch_image"
    }
    
}

struct LaunchSite: Codable {
    
    let siteName: String?
    
    enum CodingKeys: String, CodingKey {
        case siteName = "site_name_long"
    }
}
