//
//  SinglePhotoViewController.swift
//  Photos
//
//  Created by George He on 4/10/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class SinglePhotoViewController: UIViewController {
    
    var photo: Photo!
    var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds.size
        let UIImageViewSize = screen.width*3/4
        let photoView: UIImageView = UIImageView(frame: CGRectMake(screen.width/2-(UIImageViewSize/2), 100, UIImageViewSize, UIImageViewSize))
        let url: NSURL! = NSURL(string: photo.stdURL)
        photoView.image = UIImage(data: NSData(contentsOfURL: url)!)
        photoView.layer.cornerRadius = 10.0
        photoView.layer.borderWidth = 4.0
        photoView.layer.borderColor = UIColor.lightGrayColor().CGColor
        photoView.layer.masksToBounds = true
        self.view.addSubview(photoView)
        
        let user: UILabel = UILabel(frame: CGRectMake(photoView.frame.origin.x, photoView.frame.origin.y + UIImageViewSize + 30, UIImageViewSize, 20))
        user.text = "Username: \(photo.username)"
        user.backgroundColor = UIColor(white: 1, alpha: 1)
        user.textColor = UIColor.blackColor()
        self.view.addSubview(user)
        
        
        let dateUILabel: UILabel = UILabel(frame: CGRectMake(photoView.frame.origin.x, user.frame.origin.y + 30, UIImageViewSize, 20))
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let datePosted = NSDate(timeIntervalSince1970: Double(photo.datePosted)!)
        dateUILabel.text = "Posted: \(formatter.stringFromDate(datePosted))"
        dateUILabel.backgroundColor = UIColor(white: 1, alpha: 1)
        dateUILabel.textColor = UIColor.blackColor()
        self.view.addSubview(dateUILabel)
        
        let likesUILabel: UILabel = UILabel(frame: CGRectMake(photoView.frame.origin.x, dateUILabel.frame.origin.y + 30, UIImageViewSize*3/4, 20))
        self.likesLabel = likesUILabel
        likesUILabel.text = "Likes: \(photo.numLikes)"
        likesUILabel.backgroundColor = UIColor(white: 1, alpha: 1)
        likesUILabel.textColor = UIColor.blackColor()
        self.view.addSubview(likesUILabel)
        
        let likeButton: UIButton = UIButton(frame: CGRectMake(likesUILabel.frame.origin.x + UIImageViewSize/2 - 15, likesUILabel.frame.origin.y, 30, 30))
        likeButton.addTarget(self, action: "likeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        likeButton.setTitle("❤️", forState: UIControlState.Normal)
        likeButton.setTitle("💖", forState: UIControlState.Selected)
        likeButton.backgroundColor = UIColor(white: 1, alpha: 1)
        
        if (photo.liked!) {
            likeButton.selected = true
        }
        self.view.addSubview(likeButton)
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(photo: Photo) {
        super.init(nibName: nil, bundle: nil)
        self.photo = photo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func likeButtonPressed(sender: UIButton!) {
        if (!photo.liked) {
            sender.selected = true
            photo.numLikes = photo.numLikes + 1
            likesLabel.text = "Likes: \(photo.numLikes)"
            photo.liked = true
        }
        else {
            sender.selected = false
            photo.numLikes = photo.numLikes - 1
            likesLabel.text = "Likes: \(photo.numLikes)"
            photo.liked = false
        }
    }
    
}
