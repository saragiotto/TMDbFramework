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

class MovieDetailViewController: UITableViewController {

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
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.title = movieTitle()
        
        self.tableView.contentInset = UIEdgeInsets.zero
        self.tableView.backgroundColor = UIColor.black
        self.tableView.alwaysBounceVertical = false
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(BrackdropCell.classForCoder(), forCellReuseIdentifier: "backdropCell")
        self.tableView.register(ReleaseDateCell.classForCoder(), forCellReuseIdentifier: "releaseDateCell")
        self.tableView.register(OverviewCell.classForCoder(), forCellReuseIdentifier: "overviewCell")

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch indexPath.row {
        case 0:
            let cell:BrackdropCell = tableView.dequeueReusableCell(withIdentifier: "backdropCell", for: indexPath) as! BrackdropCell
            
            if movie!.backdropPath != nil {
                cell.configureWith(imagePath: movie!.backdropPath!)
            }
            
            return cell
        case 1:
            let cell:ReleaseDateCell  = tableView.dequeueReusableCell(withIdentifier: "releaseDateCell", for: indexPath) as! ReleaseDateCell
            
            cell.configureWith(releaseDate: movie!.releaseDate)
            
            return cell
        case 2:
            let cell:OverviewCell  = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! OverviewCell
            
            cell.configureWith(overview: movie!.overview)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 250.0
        case 1:
            return 44.0
        case 2:
            return 88.0
        default:
            return 44.0
        }
    }
    
    private func movieTitle() -> String {
        
        var finalTitle = "Title Not Available"
        
        if let title = movie!.title {
            finalTitle = title
        } else {
            if let originalTitle = movie!.originalTitle {
                finalTitle = originalTitle
            }
        }
        
        return finalTitle
    }
    
    private func displayMovie() {
        
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
            
            tmdbPod.loadImageFor(path: movie!.backdropPath!, type: .backdrop) { image in
                
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
