//
//  File.swift
//  OopsMovies
//
//  Created by John Kim on 4/28/23.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchMovies() -> [Movie]
}

class HomeService : HomeServiceProtocol {
    
    //We can usually use closures and/or frameworks like Combine to handle returning data from Network calls
    func fetchMovies() -> [Movie] {
        //Network API call would go here
        
        //Mocking some data for now
        return [
            Movie(
                title: "Everything Everywhere All At Once",
                  backdropImage: "everything_everywhere_background",
                  posterImage: "everything_everywhere_poster",
                  posterTitle: "everything_everywhere_poster_title",
                  description: "An aging Chinese immigrant is swept up in an insane adventure, where she alone can save what’s important to her by connecting with the lives she could have led in other universes.",
                  attributes: Attributes(
                    is4k: false,
                    isHDR: false,
                    isDolbyAtmos: false
                    )
                 ),
            Movie(
                title: "War for the Planet of the Apes",
                  backdropImage: "war_planet_apes_background",
                  posterImage: "war_planet_apes_poster",
                  posterTitle: "war_planet_apes_poster_title",
                  description: "Caesar and his apes are forced into a deadly conflict with an army of humans led by a ruthless Colonel. After the apes suffer unimaginable losses, Caesar wrestles with his darker instincts and begins his own mythic quest to avenge his kind. As the journey finally brings them face to face, Caesar and the Colonel are pitted against each other in an epic battle that will determine the fate of both their species and the future of the planet.",
                  attributes: Attributes(
                    is4k: true,
                    isHDR: true,
                    isDolbyAtmos: true
                    )
                 ),
            Movie(
                title: "Everything Everywhere All At Once",
                  backdropImage: "everything_everywhere_background",
                  posterImage: "everything_everywhere_poster",
                  posterTitle: "everything_everywhere_poster_title",
                  description: "An aging Chinese immigrant is swept up in an insane adventure, where she alone can save what’s important to her by connecting with the lives she could have led in other universes.",
                  attributes: Attributes(
                    is4k: false,
                    isHDR: false,
                    isDolbyAtmos: false
                    )
                 ),
            Movie(
                title: "War for the Planet of the Apes",
                  backdropImage: "war_planet_apes_background",
                  posterImage: "war_planet_apes_poster",
                  posterTitle: "war_planet_apes_poster_title",
                  description: "Caesar and his apes are forced into a deadly conflict with an army of humans led by a ruthless Colonel. After the apes suffer unimaginable losses, Caesar wrestles with his darker instincts and begins his own mythic quest to avenge his kind. As the journey finally brings them face to face, Caesar and the Colonel are pitted against each other in an epic battle that will determine the fate of both their species and the future of the planet.",
                  attributes: Attributes(
                    is4k: true,
                    isHDR: true,
                    isDolbyAtmos: true
                    )
                 )
        ]
        
    }
    
}
