//
//  MovieListViewCell.swift
//  MovieList
//
//  Created by Leonardo Saragiotto on 1/21/17.
//  Copyright © 2017 Leonardo Saragiotto. All rights reserved.
//

import UIKit
import TMDbFramework

class MovieListViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    var movie: TMDbMovie?
    var indexPath: IndexPath?
    
    func configureWithMovie(_ movie:TMDbMovie, atIndex:IndexPath) {
        
        self.movie = movie
        self.indexPath = atIndex
        
        moviePoster?.image = nil
        movieName?.text = nil
        movieGenre?.text = nil
        movieReleaseDate?.text = nil
        
        if let title = self.movie!.title {
            self.movieName.text = title
        } else {
            if let origTitle = self.movie!.originalTitle {
                self.movieName.text = origTitle
            } else {
                self.movieName.text = "Title not available"
            }
        }
        
        if self.movie!.genresIds != nil && self.movie!.genresIds!.count > 0{
            TMDb.sharedInstance.movieGenreFor(self.movie!.genresIds![0]) { genreName in
                if let name = genreName {
                    self.movieGenre.text = name
                } else {
                    self.movieGenre.text = "-"
                }
            }
        } else {
            self.movieGenre.text = "-"
        }
        
        if let releaseDate = self.movie!.releaseDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let releaseDateFormatted = dateFormatter.date(from: releaseDate)
            
            let newDateFormat = DateFormatter()
            newDateFormat.dateStyle = .medium
            
            self.movieReleaseDate.text = newDateFormat.string(from: releaseDateFormatted!)
        } else {
            self.movieReleaseDate.text = "To be announced"
        }
        
        self.moviePoster.image = UIImage(named: "LaunchPoster.png")!
        
        
        if self.movie!.posterPath != nil {
            
            let tmdbPod = TMDb.sharedInstance
            let posterPath = self.movie!.posterPath
            
            tmdbPod.loadImageFor(path: posterPath!, type: .poster) { [weak self] image in
                
                DispatchQueue.main.async {
                    if (posterPath! == image!.path!) {
                        self?.animatedPosterImageShow((image?.image)!)
                    }
                }
            }
            
            
        } else {
            self.moviePoster.image = UIImage(named: "NoPosterNew.png")!
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movie = nil
    }
    
    private func animatedPosterImageShow(_ posterImage: UIImage) {
        
        let posterMovie = UIImageView(image: UIImage())
        posterMovie.frame = self.moviePoster.frame
        posterMovie.alpha = 1.0
        posterMovie.backgroundColor = UIColor.black
        self.moviePoster.addSubview(posterMovie)
        self.moviePoster.image = posterImage
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            posterMovie.alpha = 0.0
        }, completion: { finished in
            posterMovie.removeFromSuperview()
        })
    }
}
