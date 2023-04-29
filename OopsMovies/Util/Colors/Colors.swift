//
//  Colors.swift
//  OopsMovies
//
//  Created by John Kim on 4/28/23.
//

import Foundation
import UIKit
import SwiftUI

class Colors {
    
    static let shared = Colors()
    
    var redHue = [
        UIColor(red: 0.933, green: 0.836, blue: 0.843, alpha: 0.4).cgColor,
        UIColor(red: 0.562, green: 0.27, blue: 0.291, alpha: 1).cgColor
    ]
    var blueHue = [
        UIColor(red: 0.537, green: 0.538, blue: 0.542, alpha: 0.4).cgColor,
        UIColor(red: 0.241, green: 0.276, blue: 0.371, alpha: 1).cgColor
    ]
    
    var redShadowGradient = [
        Color(red: 0.725, green: 0.55, blue: 0.563),
        Color(red: 0.933, green: 0.836, blue: 0.843)
    ]
    
    var blueShadowGradient = [
        Color(red: 0.322, green: 0.336, blue: 0.375),
        Color(red: 0.537, green: 0.538, blue: 0.542)
    ]
    
    var movieCellShadow = Color(red: 0, green: 0, blue: 0, opacity: 0.25)
    
}
