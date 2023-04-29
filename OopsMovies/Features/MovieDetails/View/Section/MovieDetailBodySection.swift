//
//  MovieDetailBodySection.swift
//  OopsMovies
//
//  Created by John Kim on 4/29/23.
//

import Foundation
import UIKit

class MovieDetailBodySection : UIStackView {
    
    lazy var posterTitleView : UIImageView = {
        let posterTitleView = UIImageView()
         posterTitleView.translatesAutoresizingMaskIntoConstraints = false
         posterTitleView.contentMode = .scaleAspectFill
         posterTitleView.clipsToBounds = true
        
         return posterTitleView
    }()
    
    lazy var attributeStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    lazy var descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor.white

        return descriptionLabel
    }()
    
    convenience init(parentView: UIView, posterTitle: String, attributes: Attributes, titleDescription: String) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 32
        alignment = .center
        distribution = .equalSpacing
        
        posterTitleView.image = UIImage(named: posterTitle)
        attributes.is4k ? attributeStackView.addArrangedSubview(UIImageView(image: UIImage(named: "4k_icon"))) : ()
        attributes.isHDR ? attributeStackView.addArrangedSubview(UIImageView(image: UIImage(named: "hdr_icon"))) : ()
        attributes.isDolbyAtmos ? attributeStackView.addArrangedSubview(UIImageView(image: UIImage(named: "dolby_atmos_icon"))) : ()

        descriptionLabel.text = titleDescription
        
        self.addArrangedSubview(self.posterTitleView)
        self.addArrangedSubview(self.attributeStackView)
        self.addArrangedSubview(self.descriptionLabel)
        
        descriptionLabel.widthAnchor.constraint(equalToConstant: parentView.frame.width * 0.85).isActive = true
    }
}
