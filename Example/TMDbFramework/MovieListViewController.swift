//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Leonardo Saragiotto on 1/21/17.
//  Copyright © 2017 Leonardo Saragiotto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ChameleonFramework
import TMDbFramework

private let reuseIdentifier = "MovieListViewCell"

class MovieListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var movieListVM:MovieListViewModel! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        
        movieListVM = MovieListViewModel()
        
        let rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(MovieListViewController.presentAboutScreen))
        
        rightSearchBarButtonItem.tintColor = UIColor.flatYellowColorDark()
        
        self.navigationItem.setRightBarButtonItems([rightSearchBarButtonItem], animated: true)
        
        movieListVM.loadMovies() { 
            self.collectionView?.reloadData()
        }
        
    }
    
    private struct Storyboard {
        static let movieDetailIdentifier = "movieDetail"
        static let aboutScreenIdentifier = "aboutViewController"
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        switch segue.identifier! {
        case Storyboard.movieDetailIdentifier:
            if let movieDetailVC = segue.destination as? MovieDetailViewController {
                let row = self.collectionView!.indexPathsForSelectedItems!.first!.row
                movieDetailVC.movie = movieListVM.movies?[row]
            }
        default:
            break
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if let movies = movieListVM.movies {
            return movies.count
        } else {
            return 0
        }

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieListViewCell
        
        // Configure the cell

        cell.configureWithMovie((movieListVM.movies?[indexPath.row])!)
        
        if (indexPath.row == movieListVM.movies!.count - 3) {
            self.loadMoreMovies()
        }

        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let itemWidth = screenWidth/2 - 2
        let itemHeight = (itemWidth/3) * 5
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func loadMoreMovies() {
        
        movieListVM.loadMovies() {
            
            let moviesLoaded = self.movieListVM.requestResults
            var indexPaths = [IndexPath]()
            let movieListCount = self.movieListVM.movies!.count - moviesLoaded!
            var row = 0
            
            for _ in 1...moviesLoaded! {
                
                indexPaths.append(IndexPath(item: movieListCount + row, section: 0))
                
                row += 1
            }
            
            self.collectionView?.insertItems(at: indexPaths)
        }
    }
    
    public func presentAboutScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :Storyboard.aboutScreenIdentifier) as! AboutViewController
        self.present(viewController, animated: true)
    }

}
