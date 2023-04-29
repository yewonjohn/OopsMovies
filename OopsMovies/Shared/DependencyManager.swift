//
//  DependencyManager.swift
//  OopsMovies
//
//  Created by John Kim on 4/25/23.
//

import Foundation

public class DependencyManager {

    let homeService : HomeServiceProtocol

    public init() {
        self.homeService = HomeService()
    }
}

