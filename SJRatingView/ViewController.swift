//
//  ViewController.swift
//  SJRatingView
//
//  Created by Saurabh Jain on 5/8/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SJRatingViewDelegate {

    // The Rating View
    @IBOutlet weak var rating: SJRatingView!
    @IBOutlet weak var newRating: SJRatingView!
    @IBOutlet weak var static_rating: SJRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** Animated rating view **/
        // Setting the delagate to self
        rating.delegate = self
        // Animation Duration
        rating.animationDuration = 0.2
        // By default is 5
        rating.numberOfStars = 5
        
        
        /** Non-Animated rating view **/
        // Needs to be set before changing the starScore
        newRating.animationEnabled = false
        newRating.starScore = 3
        
        
        /** Static rating view **/
        static_rating.userInteractionEnabled = false
        static_rating.animationEnabled = false
        static_rating.starScore = 2
        
    }

    // The SJRatingViewDelegate
    func ratingView(numberOfStars: Int) {
        println(numberOfStars)
    }

}

