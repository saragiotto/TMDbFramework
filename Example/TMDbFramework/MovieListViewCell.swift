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
        
        if movie.genresIds != nil && movie.genresIds!.count > 0{
            TMDb.sharedInstance.movieGenreFor(movie.genresIds![0]) { genreName in
                if let name = genreName {
                    self.movieGenre.text = name
                } else {
                    self.movieGenre.text = "-"
                }
            }
        } else {
            self.movieGenre.text = "-"
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
            
            tmdbPod.imageURLFor(path: posterPath!, type: .poster) { stringPosterPath in
            
                self.moviePoster.af_setImage(withURL: URL(string: stringPosterPath)!,
                                 placeholderImage: UIImage(named: "LaunchPoster.png")!,
                                 imageTransition: .crossDissolve(0.2))
            }
        } else {
            self.moviePoster.image = UIImage(named: "NoPosterNew.png")!
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.moviePoster.af_cancelImageRequest()
        self.moviePoster.layer.removeAllAnimations()
        self.moviePoster.image = nil
    }
}
