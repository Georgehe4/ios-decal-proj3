//
//  SinglePhotoViewController.swift
//  Photos
//
//  Created by George He on 4/10/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class SinglePhotoViewController: UIViewController {
    
    /* Photo in the view */
    var photo: Photo!
    /* A reference to the likes UILabel to be able to change the like count. */
    var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds.size
        let photoSize = screen.width*3/4
        let photoView: UIImageView = UIImageView(frame: CGRectMake(screen.width/2-(photoSize/2), 100, photoSize, photoSize))
        let url: NSURL! = NSURL(string: photo.stdURL)
        photoView.image = UIImage(data: NSData(contentsOfURL: url)!)
        photoView.layer.cornerRadius = 10.0
        photoView.layer.borderWidth = 4.0
        photoView.layer.borderColor = UIColor.lightGrayColor().CGColor
        photoView.layer.masksToBounds = true
        self.view.addSubview(photoView)
        
        let user: UILabel = UILabel(frame: CGRectMake(photoView.frame.origin.x, photoView.frame.origin.y + photoSize + 30, photoSize, 20))
        user.text = "Username: \(photo.username)"
        user.backgroundColor = UIColor(white: 1, alpha: 1)
        user.textColor = UIColor.blackColor()
        self.view.addSubview(user)
        
        
        let date: UILabel = UILabel(frame: CGRectMake(photoView.frame.origin.x, user.frame.origin.y + 30, photoSize, 20))
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let datePosted = NSDate(timeIntervalSince1970: Double(photo.datePosted)!)
        date.text = "Posted: \(formatter.stringFromDate(datePosted))"
        date.backgroundColor = UIColor(white: 1, alpha: 1)
        date.textColor = UIColor.blackColor()
        self.view.addSubview(date)
        
        
        let likes: UILabel = UILabel(frame: CGRectMake(photoView.frame.origin.x, date.frame.origin.y + 30, photoSize/2, 20))
        likesLabel = likes
        likes.text = "Likes: \(photo.numLikes)"
        likes.backgroundColor = UIColor(white: 1, alpha: 1)
        likes.textColor = UIColor.blackColor()
        self.view.addSubview(likes)
        
        let likeButton: UIButton = UIButton(frame: CGRectMake(likes.frame.origin.x + photoSize/2 - 15, likes.frame.origin.y, 30, 30))
        likeButton.addTarget(self, action: "likeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        likeButton.backgroundColor = UIColor(white: 1, alpha: 1)
        likeButton.setTitle("❤️", forState: UIControlState.Normal)
        likeButton.setTitle("💖", forState: UIControlState.Selected)
        
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
