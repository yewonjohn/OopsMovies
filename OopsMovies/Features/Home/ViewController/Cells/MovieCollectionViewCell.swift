//
//  SwiftUIView.swift
//  OopsMovies
//
//  Created by John Kim on 4/26/23.
//

import UIKit
import SwiftUI

struct MovieCellView: View {
    let movie: Movie
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let gradientColors: [Color]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .frame(width: itemWidth, height: itemHeight)
                .foregroundColor(.white)
                .offset(x: -4, y: -3)

            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue)
                .frame(width: itemWidth, height: itemHeight)
                .shadow(color: Colors.shared.movieCellShadow, radius: 12, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                )
            //So I could not figure out why the image would not fill the entire frame..
            //Spent some time on it but ended up increasing the frame of the image for the right size
            Image(movie.posterImage)
                .resizable()
                .frame(width: itemWidth * 1.21, height: itemHeight * 1.15)
                .scaledToFill()
                .clipped()
                .offset(x: 0, y: 3.2)
                .clipShape(RoundedRectangle(cornerRadius: 12))

        }
        .transformEffect(
            CGAffineTransform(
                a: 1,
                b: -0.25,
                c: 0,
                d: 1,
                tx: 0,
                ty: 0
            )
        )
    }
}
