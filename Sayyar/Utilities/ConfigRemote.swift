//
//  ConfigRemote.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 24/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation
import Firebase

class ConfigRemote : NSObject {
    
    static let shared = ConfigRemote()
    var remoteConfig: RemoteConfig!
    
    override init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func set(defaults: [String: NSObject]) {
        remoteConfig.setDefaults(defaults)
    }
    
    func fetch(completion : @escaping (_ routes: NSArray?) -> Void ) {
        remoteConfig.fetch(withExpirationDuration: 0) {(status, error) in
            guard error == nil else {
                print("Remote error: \(error!)")
                return
            }
            print("Fetched!")
            RemoteConfig.remoteConfig().activate { (error2) in
                guard error2 == nil else {
                    print("another error2: \(error2!)")
                    return
                }
                
            }
        }
    }
}
