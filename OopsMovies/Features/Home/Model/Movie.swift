//
//  Movie.swift
//  OopsMovies
//
//  Created by John Kim on 4/27/23.
//

import Foundation

struct Movie {
    var title : String
    //These images currently represent the name of the locally stored image files-
    //but are usually URLs that we render using a cacheing image url renderer (like kingfisher)
    //for better performance, I would most likely precache these images during the HomeScreen, so navigation is not choppy.
    var backdropImage : String
    var posterImage : String
    var posterTitle : String
    var description : String
    var attributes: Attributes
}
