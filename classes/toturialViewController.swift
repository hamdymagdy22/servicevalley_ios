//
//  toturialViewController.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 6/14/20.
//  Copyright © 2020 Parth Changela. All rights reserved.
//

import UIKit
import ImageSlideshow
class toturialViewController: UIViewController {
   
    
    let localSource = [BundleImageSource(imageString: "11"), BundleImageSource(imageString: "22"), BundleImageSource(imageString:
        "33"), BundleImageSource(imageString: "44"),BundleImageSource(imageString: "55"), BundleImageSource(imageString: "66"), BundleImageSource(imageString:
            "77"), BundleImageSource(imageString: "88"),BundleImageSource(imageString: "99"), BundleImageSource(imageString: "100"), BundleImageSource(imageString:"110"), BundleImageSource(imageString: "120"), BundleImageSource(imageString: "130")]
    
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var slideShowView: ImageSlideshow!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        nextPage.layer.cornerRadius = 15
        slideShowView.slideshowInterval = 0
               slideShowView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
            slideShowView.contentScaleMode = UIView.ContentMode.scaleToFill
        slideShowView.circular = false
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        pageControl.pageIndicatorTintColor = UIColor.black
        slideShowView.pageIndicator = pageControl
        slideShowView.activityIndicator = DefaultActivityIndicator()
              slideShowView.currentPageChanged = { page in
                  print("current page:", page)
                let delayInSeconds = 1.0
                if page == 12 {
                    
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {

                    UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")

                }
                
                    
                }
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(toturialViewController.didTap))
                self.slideShowView.addGestureRecognizer(recognizer)
                
              }
       self.slideShowView.setImageInputs(self.localSource)
        // Do any additional setup after loading the view.
    }
    @objc func didTap() {
                 let fullScreenController = slideShowView.presentFullScreenController(from: self)
                 // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
                 fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
             }
    
    @IBAction func toNextPage(_ sender: Any) {
        
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
    func imageSlideshowDidEndDecelerating(_ imageSlideshow: ImageSlideshow) {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
    
   
}
extension ViewController: ImageSlideshowDelegate {
   
    func imageSlideshowDidEndDecelerating(_ imageSlideshow: ImageSlideshow) {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
}
