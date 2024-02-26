//
//  ViewController.swift
//  ExpandableCollectionView
//
//  Created by Jay Raval on 2024-02-24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0)
    
    private var viewModel: ViewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listenToMovies()
        viewModel.getMovies()
        
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), 
                                forCellWithReuseIdentifier: MovieCell.Identifier.reusableIdentifier)
        collectionView.register(UINib(nibName: "MoviesHeaderView", bundle: nil),
                                forCellWithReuseIdentifier: MoviesHeaderView.Identifier.reusableIdentifier)
        
        self.setUpCollectionViewLayout()
    }
    
    private func listenToMovies() {
        viewModel.$movies
            .dropFirst()
            .sink { _ in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setUpCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize (width: collectionView.frame.size.width, height: 50)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 7.5, bottom: 0, right: 7.5)
        layout.itemSize = CGSize(width: (collectionView.frame.size.width - 30) / 2, height: (collectionView.frame.size.width - 30) / 2 + 23)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewModel.movies[section].isExpanded else { return 0 }
        return viewModel.movies[section].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configureMovie(for: viewModel.movies[indexPath .section].movies[indexPath.row])
        return cell
    }
}

extension ViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind,
                                                                                    withReuseIdentifier: "\(MoviesHeaderView.self)",
                                                                                    for: indexPath) as? MoviesHeaderView
            else {
                return collectionView.dequeueReusableSupplementaryView( ofKind: kind,
                                                                        withReuseIdentifier: "\(MoviesHeaderView.self)",
                                                                        for: indexPath)
            }
            configureHeaderSectionView(headerView, for: indexPath.section)
            
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
    private 
    func configureHeaderSectionView(_ headerView: MoviesHeaderView, for section: Int) {
        headerView.delegate = self
        headerView.configureHeader(for: section, isExpanded: viewModel.movies[section].isExpanded)
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem - 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return viewModel.movies[section].isExpanded ? sectionInsets : UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return sectionInsets.left
    }
}

extension ViewController : Expandable
{
    func didTapSection(_ section: Int) {
        print(section)
        viewModel.didTapSection(section)
    }
}
