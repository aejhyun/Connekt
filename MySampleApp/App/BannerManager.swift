//
//  UserSearchInformation.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 8/30/16.
//
//

import Foundation
import UIKit
import AWSCore
import AWSCognito

class BannerManager {
    
    static let sharedInstance: BannerManager = BannerManager()
    
    private let bannersKey: String = "banners"
    private let datasetKey: String = "userInformation"
    
    func saveBannerToCognito(banner: Banner) {
        let syncClient: AWSCognito = AWSCognito.defaultCognito()
        let userInformation: AWSCognitoDataset = syncClient.openOrCreateDataset(datasetKey)
        userInformation.setValue(banner, forKey: bannersKey)
        userInformation.synchronize().continueWithExceptionCheckingBlock({(result: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                print("saveSettings AWS task error: \(error.localizedDescription)")
            }
        })
    }
    
}
