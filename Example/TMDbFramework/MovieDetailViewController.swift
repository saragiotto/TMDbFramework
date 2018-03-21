//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Leonardo Saragiotto on 1/22/17.
//  Copyright © 2017 Leonardo Saragiotto. All rights reserved.
//

import UIKit
import ChameleonFramework
import Kingfisher

class MovieDetailViewController: UITableViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropMovie: UIImageView!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var releaseDate: UILabel!
    
    var viewModel:MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initViewController()
        
        self.initViewModel()
    }
    
    private func initViewController() {
        self.title = self.viewModel?.titleForView ?? ""
        
        self.tableView.contentInset = .zero
        self.tableView.separatorInset = .zero
        self.tableView.layoutMargins = .zero
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.backgroundColor = UIColor.black
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.alwaysBounceVertical = false
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(BrackdropCell.self, forCellReuseIdentifier: "backdropCell")
        self.tableView.register(ReleaseDateCell.self, forCellReuseIdentifier: "releaseDateCell")
        self.tableView.register(OverviewCell.self, forCellReuseIdentifier: "overviewCell")
        self.tableView.register(CastCell.self, forCellReuseIdentifier: "castCell")
    }
    
    private func initViewModel() {
        self.viewModel?.reloadTableViewClosure = {
            self.tableView.reloadData()
        }
        
        self.viewModel?.fetchDetails()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch indexPath.row {
        case 0:
            let cell:BrackdropCell = tableView.dequeueReusableCell(withIdentifier: "backdropCell", for: indexPath) as! BrackdropCell
            cell.configureWith(self.viewModel!.getBarckdropCellModel())
            return cell
        case 1:
            let cell:ReleaseDateCell  = tableView.dequeueReusableCell(withIdentifier: "releaseDateCell", for: indexPath) as! ReleaseDateCell
            cell.configureWith(self.viewModel!.getReleaseDateCellModel())
            return cell
        case 2:
            let cell:OverviewCell  = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! OverviewCell
            cell.configureWith(self.viewModel!.getOverviewCellModel())
            return cell
        default:
            let cell:CastCell  = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCell
            cell.configureWith(self.viewModel!.getCastCellMode(at: indexPath))
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
            return OverviewCell.getOverviewCellSize(for: self.viewModel!.getOverviewCellModel()).height
        default:
            return 56.0
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
}
