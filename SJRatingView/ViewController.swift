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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rating.backgroundColor = UIColor.whiteColor()
        
        // Setting the delagate to self
        rating.delegate = self
        
        // Animation Duration
        rating.animationDuration = 0.2
        
        // By default is 5
        rating.numberOfStars = 5
        
    }

    // The SJRatingViewDelegate
    func ratingView(numberOfStars: Int) {
        println(numberOfStars)
    }

}

