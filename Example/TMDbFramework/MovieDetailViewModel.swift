//
//  MovieDetailViewModel.swift
//  TMDbFramework_Example
//
//  Created by Leonardo Augusto N Saragiotto on 21/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import TMDbFramework

class MovieDetailViewModel {
    
    private var movie: TMDbMovie?
    
    var numberOfRows: Int {
        if let movie = movie, let cast = movie.cast {
            return 3 + cast.count
        }
        
        return 3
    }
    
    var titleForView: String {
        var finalTitle = "Movie"
        
        if let title = movie!.title {
            finalTitle = title
        } else {
            if let originalTitle = movie!.originalTitle {
                finalTitle = originalTitle
            }
        }
        
        return finalTitle
    }
    
    var reloadTableViewClosure: (()->())?
    
    init(_ movie:TMDbMovie) {
        self.movie = movie
    }
    
    func fetchDetails() {
        TMDb.shared.creditsFor(self.movie!) { movie in
            
            if let movie = movie {
                self.movie = movie
                self.reloadTableViewClosure?()
            }
        }
    }
    
    func getBarckdropCellModel() -> BackdropCellViewModel {
        return BackdropCellViewModel(backdroPath: self.movie!.backdropPath ?? "")
    }
    
    func getReleaseDateCellModel() -> ReleaseDateCellViewModel {
        if let releaseDate = self.movie?.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let releaseDateFormatted = dateFormatter.date(from: releaseDate)
            
            let newDateFormat = DateFormatter()
            newDateFormat.dateStyle = .medium
            
            return ReleaseDateCellViewModel(releaseDate: "Release Date " + newDateFormat.string(from: releaseDateFormatted!))
        }
        
        return ReleaseDateCellViewModel(releaseDate: "To be announced")
    }
    
    func getOverviewCellModel() -> OverviewCellViewModel {
        return OverviewCellViewModel(overview: self.movie!.overview ?? "")
    }
    
    func getCastCellMode(at indexPath:IndexPath) -> CastCellViewModel {
        let row = indexPath.row - 3
        let cast = self.movie!.cast![row]
        
        return CastCellViewModel(name: cast.name ?? "",
                                 character: cast.character ?? "",
                                 profilePath: cast.profilePath ?? "",
                                 gender: cast.gender ?? 1)
        
    }
}

struct BackdropCellViewModel {
    let backdroPath: String
}

struct ReleaseDateCellViewModel {
    let releaseDate: String
}

struct OverviewCellViewModel {
    let overview: String
}

struct CastCellViewModel {
    let name: String
    let character: String
    let profilePath: String
    let gender: Int
}
