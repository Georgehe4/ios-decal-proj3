//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var photos: [Photo]!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        
        
        let screen = UIScreen.mainScreen().bounds.size
        let layout = UICollectionViewFlowLayout()
        
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, screen.width, screen.height), collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.backgroundColor = UIColor(white: 1, alpha: 1)
        
        
        
        self.navigationItem.title = "Popular Images"
        collectionView.registerClass(CollectionViewImageCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        self.view.addSubview(collectionView!)
    }
    
    /*
    * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
    * Examples include cellForItemAtIndexPath, numberOfSections, etc.
    */
    
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let url: NSURL! = NSURL(string: photo.stdURL)
        
        let photoData: NSData! = NSData(contentsOfURL: url)
        
        let photoImage : UIImage! = UIImage(data: photoData)
        
        imageView.image = photoImage
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderWidth = 4.0
        imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        imageView.layer.masksToBounds = true

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photographs = photos {
            return photographs.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedPhoto : Photo! = photos[indexPath.item]
        presentSinglePicture(selectedPhoto)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CollectionViewImageCell
        loadImageForCell(photos[indexPath.item], imageView: cell.image)
        return cell
    }
    
    func presentSinglePicture(photo: Photo) {
        let singleViewController: SinglePhotoViewController = SinglePhotoViewController(photo: photo)
        self.navigationController?.pushViewController(singleViewController, animated: true)
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

