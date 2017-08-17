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
    
    func configureWithMovie(_ movie:TMDbMovie) {
        
        moviePoster?.image = nil
        movieName?.text = nil
        movieGenre?.text = nil
        movieReleaseDate?.text = nil
        
        if let title = movie.title {
            self.movieName.text = title
        } else {
            if let origTitle = movie.originalTitle {
                self.movieName.text = origTitle
            } else {
                self.movieName.text = "Title not available"
            }
        }
        
        if movie.genresIds == nil {
            self.movieGenre.text = "-"
        } else {
            TMDb.sharedInstance.movieGenreFor(id: movie.genresIds![0]) { genreName in
                if let name = genreName {
                    self.movieGenre.text = name
                } else {
                    self.movieGenre.text = "-"
                }
            }
        }
        
        if let releaseDate = movie.releaseDate {
            
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
        
        
        if movie.posterPath != nil {
            
            let tmdbPod = TMDb.sharedInstance
            let posterPath = movie.posterPath
            
            tmdbPod.loadImageFor(path: movie.posterPath!, type: .Poster) { image in
                
                if (posterPath == image?.path!) {
                    self.animatedPosterImageShow((image?.image)!)
                }
            }
            
            
        } else {
            self.moviePoster.image = UIImage(named: "NoPosterNew.png")!
        }
        
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
