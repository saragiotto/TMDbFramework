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

class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropMovie: UIImageView!
    @IBOutlet weak var overview: UITextView!
    
    
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var cast: UILabel!
    
    
    @IBOutlet weak var runTime: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var populatiry: UILabel!
    @IBOutlet weak var website: UILabel!
    
    @IBOutlet weak var castTableView: UITableView!
    
    var movie: TMDbMovie?
    
    private var curtainsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        overview.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
//        castTableView.delegate = self
//        castTableView.dataSource = self
//        
        TMDb.sharedInstance.movieDetailFor(movie!) {movie in
            self.movie = movie
            
            self.displayMovie()
        }
    
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    private func updateScrollViewHeigh(_ heigh: CGFloat) {
        
        let newHeigh = self.scrollView.contentSize.height + heigh
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: newHeigh)
    }
    
    private func displayMovie() {
        
//        website.text = " "
//        cast.text = " "
//        runTime.text = ""
        
        if let title = movie!.title {
            self.navigationItem.title = title
        } else {
            if let originalTitle = movie!.originalTitle {
                self.navigationItem.title = originalTitle
            } else {
                self.navigationItem.title = "Title Not Available"
            }
        }
        
        if let overviewMovie = movie!.overview {
            overview.text = overviewMovie
        } else {
            overview.text = "Overview not available."
        }
        
        self.updateScrollViewHeigh(overview.contentSize.height)
        
//        if let movieDate = movie!.releaseDate {
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            
//            let releaseDateFormatted = dateFormatter.date(from: movieDate)
//            
//            let newDateFormat = DateFormatter()
//            newDateFormat.dateStyle = .medium
//            
//            releaseDate.text = newDateFormat.string(from: releaseDateFormatted!)
//        } else {
//            releaseDate.text = "To be announced"
//        }
//        
//        self.cast.text = ""
//        
//        self.genre.text = ""
        
//        let ganreNames = movie!.genresIds!.flatMap() { (genreId:Int) -> (String?) in
//            var genreName:String? = nil
//            TMDb.sharedInstance.movieGenreFor(id: genreId) { name in
//                
//                genreName = name
//            }
//            
//            return genreName
//        }
//        
//        self.genre.text = ganreNames.joined(separator: ", ")
        
//        if let popMovie = movie!.voteAverage, popMovie > 0.0 {
//            populatiry.textColor = UIColor.flatYellowColorDark()
//            populatiry.text = String(format:"%.1f", popMovie)
//        } else {
//            populatiry.text = ""
//        }
        
        if movie!.backdropPath != nil {
            
            let tmdbPod = TMDb.sharedInstance
            tmdbPod.imageQuality = .medium
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            tmdbPod.loadImageFor(path: movie!.backdropPath!, type: .backdrop) { image in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                self.animatedImageShow((image?.image)!)
            }
            
        } else {
            backdropMovie.image = UIImage(named: "NoPosterNew.png")!
        }
        
        
//        if (movie!.homepage != nil && !(movie!.homepage!.isEmpty)) {
//            
//            if let url = URL(string: movie!.homepage!) {
//                
//                if let host = url.host {
//                
//                    self.website.textColor = UIColor.flatYellowColorDark()
//                    self.website.text = host
//                    self.website.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MovieDetailViewController.openWebsite)))
//                } else {
//                    self.website.text = "Not available"
//                }
//            } else {
//                self.website.text = "Not available"
//            }
//        } else {
//            self.website.text = "Not available"
//        }
    }
    
    private func animatedImageShow(_ image: UIImage) {
        
        let bdMovie = UIImageView(image: UIImage())
        bdMovie.frame = self.backdropMovie.frame
        bdMovie.alpha = 1.0
        bdMovie.backgroundColor = UIColor.black
        self.backdropMovie.addSubview(bdMovie)
        self.backdropMovie.image = image
        
        self.updateScrollViewHeigh(backdropMovie.image!.size.height)
        
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
