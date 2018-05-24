//
//  THActivityNetworkHelper.swift
//  Thanos
//
//  Created by Richard Frank on 23/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import UIKit

class ActivityNetwork {
    static var isVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            return UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
}
