//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Leonardo Saragiotto on 1/22/17.
//  Copyright © 2017 Leonardo Saragiotto. All rights reserved.
//

import UIKit
import ChameleonFramework
import TMDbFramework

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backdropMovie: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overviewInfo: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var cast: UILabel!
    
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var populatiry: UILabel!
    @IBOutlet weak var website: UILabel!
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    var movie: TMDbMovie?
    
    private var curtainsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDb.sharedInstance.movieDetailFor(movie!) {movie in
            self.movie = movie
            
            self.displayMovie()
        }
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NSLog("scroll view \(self.detailScrollView)")
    }
    
    private func displayMovie() {
        
        website.text = " "
        cast.text = " "
        runTime.text = ""
        
        if let title = movie!.title {
            movieTitle.text = title
        } else {
            if let originalTitle = movie!.originalTitle {
                movieTitle.text = originalTitle
            } else {
                movieTitle.text = "Title Not Available"
            }
        }
        
        self.navigationItem.title = movieTitle.text!
        
        if let overview = movie!.overview {
            overviewInfo.text = overview
        } else {
            overviewInfo.text = "Overview not available."
        }
        
        if let movieDate = movie!.releaseDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let releaseDateFormatted = dateFormatter.date(from: movieDate)
            
            let newDateFormat = DateFormatter()
            newDateFormat.dateStyle = .medium
            
            releaseDate.text = newDateFormat.string(from: releaseDateFormatted!)
        } else {
            releaseDate.text = "To be announced"
        }
        
        self.genre.text = "-"
        
        movie!.genresIds!.map() { genreId in
            TMDb.sharedInstance.movieGenreFor(id: genreId) { genreName in
                self.genre.text! += genreName!
            }
            return
        }
        
        if let popMovie = movie!.voteAverage, popMovie > 0.0 {
            populatiry.textColor = UIColor.flatYellowColorDark()
            populatiry.text = String(format:"%.1f", popMovie)
        } else {
            populatiry.text = ""
        }
        
        if movie!.backdropPath != nil {
            
            let tmdbPod = TMDb.sharedInstance
            tmdbPod.imageQuality = .Medium
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            tmdbPod.loadImageFor(path: movie!.backdropPath!, type: .Backdrop) { image in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                self.animatedImageShow((image?.image)!)
            }
            
        } else {
            backdropMovie.image = UIImage(named: "NoPosterNew.png")!
        }
        
        
        if let homepage = movie!.homepage {
            
            let url = URL(string: homepage)
            
            self.website.textColor = UIColor.flatYellowColorDark()
            self.website.text = url!.host!
            self.website.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MovieDetailViewController.openWebsite)))
            
        } else {
            self.website.text = "Not available"
        }
    }
    
    private func animatedImageShow(_ image: UIImage) {
        
        let bdMovie = UIImageView(image: UIImage())
        bdMovie.frame = self.backdropMovie.frame
        bdMovie.alpha = 1.0
        bdMovie.backgroundColor = UIColor.black
        self.backdropMovie.addSubview(bdMovie)
        self.backdropMovie.image = image
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            bdMovie.alpha = 0.0
        }, completion: { finished in
            bdMovie.removeFromSuperview()
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    public func openWebsite() {
        if let website = self.movie!.homepage {
            UIApplication.shared.open(URL.init(string: website)!, options: [:], completionHandler: nil)
        }
        
        return
    }
}
