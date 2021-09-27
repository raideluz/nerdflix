//
//  MovieCollectionViewCell.swift
//  Nerdflix
//
//  Created by Natália Carolina Dos Santos on 25/09/21.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "MovieCollectionViewCell"
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        imageMovie.layer.cornerRadius = 15
    }
    
    func setupModel (_ movie: MovieItemModel?) {
        guard let movieModel = movie else {return}
        labelMovieTitle.text = movieModel.fullTitle
        
        guard let urlImage = movie?.image else {return}
        if let url = URL(string: urlImage) {
            imageMovie.kf.setImage(with: url)
        }
    }
}
