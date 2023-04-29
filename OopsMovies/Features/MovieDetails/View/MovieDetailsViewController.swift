//
//  MovieDetailsViewController.swift
//  OopsMovies
//
//  Created by John Kim on 4/27/23.
//

import UIKit

class MovieDetailsViewController : UIViewController {
    
    //MARK: - Properties
    let viewModel : MovieDetailsViewModelProtocol
    let movieTitle : String
    let backdropImage: String
    let posterImage: String
    let posterTitle: String
    let attributes : Attributes
    let titleDescription: String
    let backgroundColor: [CGColor]

    //MARK: - Lifecycle Methods
    init(viewModel: MovieDetailsViewModelProtocol, movieTitle: String, backdropImage: String, posterImage: String, posterTitle: String, attributes: Attributes, titleDescription: String, backgroundColor: [CGColor]) {
        self.viewModel = viewModel
        self.movieTitle = movieTitle
        self.backdropImage = backdropImage
        self.posterImage = posterImage
        self.posterTitle = posterTitle
        self.attributes = attributes
        self.titleDescription = titleDescription
        self.backgroundColor = backgroundColor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
        configureConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //configuring scrollView content size
        if let navBarHeight = navigationController?.navigationBar.frame.height {
            scrollView.contentInset = UIEdgeInsets(top: -navBarHeight*2, left: 0, bottom: navBarHeight*3, right: 0)
        }
        let subviews = [posterImageView, movieDetailBodySection]
        let totalHeight = subviews.reduce(0) { $0 + $1.frame.height }

        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: totalHeight * 1.15)
    }
    
    //MARK: - UI Properties
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(cgColor: backgroundColor[1])
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true

        return scrollView
    }()
    
    lazy var backdropImageView : UIImageView = {
       let backdropImageView = UIImageView()
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        backdropImageView.image = UIImage(named: backdropImage)
        
        return backdropImageView
    }()
    
    lazy var backdropImageOverlay : UIView = {
        let backdropImageOverlay = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))

        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        backdropImageOverlay.addSubview(shapes)

        let shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        shadowLayer.bounds = shapes.bounds
        shadowLayer.position = shapes.center
        shapes.layer.addSublayer(shadowLayer)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = backgroundColor
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.frame = backdropImageOverlay.bounds
        backdropImageOverlay.layer.addSublayer(gradientLayer)
        backdropImageOverlay.layer.cornerRadius = 38
            
        return backdropImageOverlay
    }()
    
    lazy var posterImageView : UIImageView = {
       let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.image = UIImage(named: posterImage)
        
        return posterImageView
    }()
    
    lazy var movieDetailBodySection : MovieDetailBodySection = {
        let movieDetailBodySection = MovieDetailBodySection(parentView: view, posterTitle: posterTitle, attributes: attributes, titleDescription: titleDescription)
        
        return movieDetailBodySection
    }()
    
    lazy var shareButton : UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 66, height: 66))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share_icon"), for: .normal)
        button.backgroundColor = UIColor(red: 0.367, green: 0.367, blue: 0.367, alpha: 0.95)
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(shareMovieDetails), for: .touchUpInside)

        return button
    }()
    
    //MARK: - Layout Methods
    
    func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backdropImageView)
        scrollView.addSubview(backdropImageOverlay)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(movieDetailBodySection)
        view.addSubview(shareButton)
    }
    
    func configureConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
        backdropImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        backdropImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        backdropImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        backdropImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        backdropImageOverlay.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        backdropImageOverlay.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        backdropImageOverlay.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        backdropImageOverlay.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 90).isActive = true
        posterImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: (view.layer.frame.height * 0.45)).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: (view.layer.frame.width * 0.68)).isActive = true
        
        movieDetailBodySection.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 32).isActive = true
        movieDetailBodySection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 66).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
    //MARK: - Operation Functions
    
    @objc func shareMovieDetails(_ sender: UIButton) {
        viewModel.shareMovie(navigationController: navigationController, toShare: [UIImage(named: posterImage) ?? "", "Title: \(movieTitle)", "Description: \(titleDescription)"])
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        viewModel.handlePan(view, navigationController: navigationController, gesture: gesture)
       }
}
