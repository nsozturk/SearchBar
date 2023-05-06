//
//  MovieCell.swift
//  SearchBar
//
//  Created by enes ozturk on 6.05.2023.
//

import SDWebImage
import UIKit
class MovieCell: UICollectionViewCell {
    static let ID = "MovieCell"
    
    private var MoviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //  imageView.image = UIImage(systemName: "house")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(MoviePosterImageView)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCell {
    func configureUI() {
        MoviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        MoviePosterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        MoviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        MoviePosterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        MoviePosterImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    func updateCell(posterURL: String?) {
        if let posterURL = posterURL {
            guard let CompleteURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterURL)") else { return }
            MoviePosterImageView.sd_setImage(with: CompleteURL)
        }
    }
}
