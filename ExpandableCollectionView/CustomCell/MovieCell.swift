//
//  MovieCell.swift
//  ExpandableCollectionView
//
//  Created by Jay Raval on 2024-02-24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    enum Identifier {
        static let reusableIdentifier = "MovieCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = imgView.frame.height/2
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
    
    func configureMovie(for movie: MovieDisplayable) {
        self.lblTitle.text = movie.title
    }

}
