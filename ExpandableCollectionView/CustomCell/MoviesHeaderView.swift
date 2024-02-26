//
//  MoviesHeaderView.swift
//  ExpandableCollectionView
//
//  Created by Jay Raval on 2024-02-24.
//

import UIKit

protocol Expandable : AnyObject {
    func didTapSection(_ section: Int)
}

class MoviesHeaderView: UICollectionReusableView {

    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var lblSectionHeader: UILabel!
    
    var delegate: Expandable!
    
    enum Identifier {
        static let reusableIdentifier = "MoviesHeaderView"
    }

    private let sectionTitle: (Int) -> String = { section in
        switch section {
        case 0:
            return "Section One"
        case 1:
            return "Section Two"
        case 2:
            return "Section Three"
        case 3:
            return "Section Four"
        default:
            return "Section~"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureHeader(for section:Int, isExpanded: Bool) {
        self.arrow.tag = section
        self.lblSectionHeader.text = self.sectionTitle(section)
        self.arrow.transform = CGAffineTransform(rotationAngle: isExpanded ? .pi : 0)
    }
    
    @IBAction func didTapExpand(_ sender: UIButton) {
        print("didTapExpand")
        delegate?.didTapSection(self.arrow.tag)
    }
}
