//
//  ViewController.swift
//  OopsMovies
//
//  Created by John Kim on 4/25/23.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    let homeViewModel : HomeViewModelProtocol
    var movies : [Movie] = []

    //MARK: - Lifecycle methods
    
    init(homeViewModel: HomeViewModelProtocol) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureConstraints()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - UI Properties
    
    lazy var titleLabel : UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        titleLabel.textColor = .black
        titleLabel.text = "Library"
        return titleLabel
    }()
    
    lazy var addButton : UIBarButtonItem = {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        return addButton
    }()
    
    lazy var moviesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 50
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    //MARK: - Operation Functions
    
    @objc func addButtonTapped() {
        // Handle add button tapped (didn't have time to 
    }
    
    func fetchMovies() {
        //would normally handle this in an async closure, and make sure to interact with UI on the main thread
        movies = homeViewModel.fetchMovies()
        moviesCollectionView.reloadData()
    }
    
    //MARK: - Layout Functions
    
    func setupLayout(){
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = addButton
        view.addSubview(titleLabel)
        view.addSubview(moviesCollectionView)
    }
    
    func configureConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        moviesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let backgroundColor = (indexPath.row % 2 == 0) ? Colors.shared.redHue : Colors.shared.blueHue
        
        homeViewModel.navigateToMovieDetails(navigationController: navigationController, movie: movie, backgroundColor: backgroundColor)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let movie = movies[indexPath.row]
        
        let collectionViewWidth = collectionView.frame.width - 60
        let totalSpacing: CGFloat = 50
        let itemWidth = (collectionViewWidth - totalSpacing) / 3
        let itemHeight = itemWidth * 1.7
        //the color gradient will alternate between each cell
        let gradientColors = (indexPath.row % 2 == 0) ? Colors.shared.redShadowGradient : Colors.shared.blueShadowGradient

        if #available(iOS 16.0, *) {
            cell.contentConfiguration = UIHostingConfiguration {
                MovieCellView(
                    movie: movie,
                    itemWidth: itemWidth,
                    itemHeight: itemHeight,
                    gradientColors: gradientColors
                )
            }
        } else {
            // Fallback on earlier versions (didn't have time to set this up)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the item size to fit three items in each row
        let collectionViewWidth = collectionView.frame.width - 60
        let spacing: CGFloat = 10
        let totalSpacing: CGFloat = spacing * 4
        let itemWidth = (collectionViewWidth - totalSpacing) / 3
        let itemHeight = itemWidth * 1.7
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
