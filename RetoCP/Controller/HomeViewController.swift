//
//  HomeViewController.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import UIKit
import ImageSlideshow

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moviesSilde: ImageSlideshow!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var moviesSource: [InputSource] = []
    var movies: Movies?
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        getMovies()
    }
    
    func getMovies() {
        Services.getMovies(endpoint: .movies) { (movies) in
            guard let fetchedMovies = movies else { return }
            self.moviesSource = fetchedMovies.moviesImg
            self.initiateSlide()
        }
        
    }
    
    private func initiateSlide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.moviesSilde.slideshowInterval = 4.0
            self.moviesSilde.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
            self.moviesSilde.contentScaleMode = UIViewContentMode.scaleAspectFit

            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = UIColor.black
            self.moviesSilde.pageIndicator = pageIndicator

            self.moviesSilde.activityIndicator = DefaultActivityIndicator()
            self.moviesSilde.delegate = self

            
            self.moviesSilde.setImageInputs(self.moviesSource)

            let recognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.didTap))
            self.moviesSilde.addGestureRecognizer(recognizer)
        }
    }
    
    @objc func didTap() {
        guard let tabbarController = UIApplication.shared.tabbarController() as? TabBarViewController else { return }
        tabbarController.selectedIndex = 2
    }
    
}

extension HomeViewController: ImageSlideshowDelegate {

}
