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
    
    var movieIndex: Int? {
        didSet {
            updateCell()
        }
    }
    
    private var cellMovie = Movie()
    
    private func updateCell() {
        
        let movieApi = MovieDBApi.sharedInstance
        
        moviePoster?.image = nil
        movieName?.text = nil
        movieGenre?.text = nil
        movieReleaseDate?.text = nil
        
        cellMovie = movieApi.movies![movieIndex!]
        
        if let title = cellMovie.title {
            self.movieName.text = title
        } else {
            if let origTitle = cellMovie.originalTitle {
                self.movieName.text = origTitle
            } else {
                self.movieName.text = "Title not available"
            }
        }
        
        if cellMovie.genres_ids.isEmpty {
            self.movieGenre.text = "-"
        } else {
            self.movieGenre.text = Genre.genreName(id: cellMovie.genres_ids[0], genres: movieApi.genres!)
        }
        
        if let releaseDate = cellMovie.releaseDate {
            
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
        
        if let posterImg = cellMovie.posterImage {
            self.moviePoster.image = posterImg
        } else {
            
            if cellMovie.posterPath != nil {
                
                let tmdbPod = TMDb.sharedInstance
                tmdbPod.imageQuality = .Medium
                
                let posterPath = cellMovie.posterPath
                
                tmdbPod.loadConfiguration() { _ in
                
                    tmdbPod.loadImageFor(path: self.cellMovie.posterPath!, type: .Poster) { image in
                        
                        if (posterPath == image?.path!) {
                            self.animatedPosterImageShow((image?.image)!)
                        }
                    }
                }
                
                
            } else {
                self.moviePoster.image = UIImage(named: "NoPosterNew.png")!
            }
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
