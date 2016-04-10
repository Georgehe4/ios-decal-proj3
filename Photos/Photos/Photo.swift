//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The url of the standard image */
    var stdURL : String!
    
    /* The username of photographer */
    var username : String!
    
    /* Time of posting as NSDate */
    var datePosted: String!
    
    /* The number of likes the photo has */
    var numLikes : Int!
    
    /* True if the user has already liked this photo */
    var liked: Bool!
    
    /* The url to the thumbnail photo file */
    var thumbnailURL : String!
    
    /* Parses a NSDictionary and creates a photo object */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
        thumbnailURL = data.valueForKey("images")?.valueForKey("thumbnail")?.valueForKey("url") as! String

        username = data.valueForKey("user")?.valueForKey("username") as! String

        numLikes = data.valueForKey("likes")?.valueForKey("count") as! Int
        
        stdURL = data.valueForKey("images")?.valueForKey("standard_resolution")?.valueForKey("url") as! String
        
        datePosted = data.valueForKey("created_time") as! String
        
        liked = false
        
    }

}