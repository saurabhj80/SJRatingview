//
//  SJRatingView.swift
//  SJRatingView
//
//  Created by Saurabh Jain on 5/8/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

protocol SJRatingViewDelegate {
    
    func ratingView(numberOfStars: Int)
}


class SJRatingView: UIView {
    
    /***********************************
                Interface
    ***********************************/
    
    // The number of stars to be displayed
    var numberOfStars:Int = 5 {
        didSet {
            if numberOfStars > 0 {
                setNeedsDisplay()
            }
        }
    }
    
    var animationDuration: CFTimeInterval = 0.5
    
    // The delegate
    var delegate: SJRatingViewDelegate?
    
    // To set the filled star image
    func setFilledStarImage(image: UIImage?) {
        filled_star = image
    }
    
    // To set the unfilled star image
    func setUnfilledStarImage(image: UIImage?) {
        unfilled_star = image
    }
    
    // The selected star
    var starScore: Int = 5 {
        didSet {
            updateUI(starScore)
        }
    }
    
    var animationEnabled = true
    
    /***********************************
            Private - Variables
    ***********************************/
    
    private var tap_recognizer: UITapGestureRecognizer!
    
    private var unfilled_star = UIImage(named: "single_star") {
        didSet{
            if let unfilled_star = unfilled_star {
                setNeedsDisplay()
            }
        }
    }
    
    private var filled_star = UIImage(named: "single_star_filled") {
        didSet {
            if let filled_star = filled_star {
                setNeedsDisplay()
            }
        }
    }
    
    // The Width of the Star
    private var starWidth: CGFloat {
        get {
            return CGRectGetWidth(bounds) / CGFloat(numberOfStars)
        }
    }
    
    // The view containing the unfilled star
    private var backgroundView: UIView!
    // The view containing the filled star
    private var foregroundView: UIView!
    
    /***********************************
                Init
    ***********************************/
    
    // Convenience Init for providing images
    convenience init(filledStarImage: UIImage?, unfilledStarImage: UIImage?) {
        self.init(frame: CGRectZero)
        filled_star = filledStarImage
        unfilled_star = unfilledStarImage
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetUp()
    }
    
    private func initialSetUp() {
        
        // Set the background color to be white
        backgroundColor = UIColor.whiteColor()
        
        // Add the tap recognizer
        tap_recognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        addGestureRecognizer(tap_recognizer)
        
        backgroundView = UIView(frame: bounds)
        foregroundView = UIView(frame: bounds)
        
        autoresizesSubviews = true
        backgroundView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        foregroundView.autoresizingMask = .FlexibleWidth | .FlexibleHeight

        // Important
        foregroundView.clipsToBounds = true
        
        addSubview(backgroundView)
        addSubview(foregroundView)
    }
    
    /*************************************/
    
    private func updateUI(numberOfStar: Int) {
        
        var frame = foregroundView.frame
        frame.size.width = starWidth * CGFloat(numberOfStar)
        
        if animationEnabled {
            UIView.animateWithDuration(animationDuration) { [unowned self] in
                self.foregroundView.frame = frame
            }
        } else {
            self.foregroundView.frame = frame
        }

        
        // Tells the delgate that the number of selected stars have changed
        delegate?.ratingView(numberOfStar)
    }

}

extension SJRatingView {
    
    override func drawRect(rect: CGRect) {
        
        let height = CGRectGetHeight(rect)
        let width = CGRectGetWidth(rect)
        
        for i in 0..<numberOfStars {
            
            // X distance
            let xOffset: CGFloat = CGFloat(i) * starWidth
            
            // Background View
            var img_view = UIImageView(frame: CGRectMake(xOffset, 0, starWidth, height))
            img_view.image = unfilled_star
            backgroundView.addSubview(img_view)
            
            // Foreground View
            var fore_img_view = UIImageView(frame: CGRectMake(xOffset, 0, starWidth, height))
            fore_img_view.image = filled_star
            foregroundView.addSubview(fore_img_view)
        }
    }
    
}

// Handling the Tap Recognizer
extension SJRatingView {
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        
        let touch = recognizer.locationInView(self)
        
        let xPosition = touch.x / starWidth
        let starPos = Int(xPosition)
        
        starScore = starPos + 1
    }
}

