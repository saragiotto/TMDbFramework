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
import Kingfisher

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
        
        self.title = self.movieTitle()
        
        self.tableView.contentInset = .zero
        self.tableView.separatorInset = .zero
        self.tableView.layoutMargins = .zero
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.backgroundColor = UIColor.black
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.alwaysBounceVertical = false
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(BrackdropCell.classForCoder(), forCellReuseIdentifier: "backdropCell")
        self.tableView.register(ReleaseDateCell.classForCoder(), forCellReuseIdentifier: "releaseDateCell")
        self.tableView.register(OverviewCell.classForCoder(), forCellReuseIdentifier: "overviewCell")
        self.tableView.register(CastCell.classForCoder(), forCellReuseIdentifier: "castCell")
        
        TMDb.sharedInstance.creditsFor(self.movie!) { movie in
            
            if (movie != nil) {
                self.movie = movie!
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.movie?.cast != nil && (self.movie?.cast!.count)! > 0) {
            return 3 + (self.movie?.cast?.count)!
        }
        
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
            let cell:CastCell  = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCell
            
            cell.configureWith(cast: movie!.cast![indexPath.row - 3])
            
            return cell
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
            return 56.0
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
        
        if movie!.backdropPath != nil {
            
            let tmdbPod = TMDb.sharedInstance
            tmdbPod.imageQuality = .medium
            
            tmdbPod.loadImageFor(path: movie!.backdropPath!, type: .backdrop) { image in
                
                self.backdropMovie.kf.setImage(with: URL(string: image!.path!)!,
                                        placeholder: UIImage(named: "LaunchPoster.png"),
                                            options:[.transition(.fade(0.2))])
            }
            
        } else {
            backdropMovie.image = UIImage(named: "NoPosterNew.png")!
        }
        
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
