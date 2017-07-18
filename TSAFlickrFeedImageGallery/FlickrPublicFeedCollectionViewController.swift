//
//  FlickrPublicFeedCollectionViewController.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/16/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import UIKit
import AlamofireImage

/**
 * FlickrPublicFeedCollectionViewController: Collection view controller show images fetched from flickr public feeds.
 */

//Custom cell Identifier for UICollectionViewCell
private let reuseIdentifier = "ImageCell"
//Segue identifier of image details view controller
private let showImageDetailsIdentifier = "ShowImageDetails"

class FlickrPublicFeedCollectionViewController: UICollectionViewController {
    var flickrImages = [FlickrImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        //request public feed
        let url = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
        self.fetchImages(flickrLink: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Check showImageDetailsIdentifier to show image detailed view to load
        if segue.identifier == showImageDetailsIdentifier {
            //retrive FlickrImageViewController for segue
            let imageViewController = segue.destination as! FlickrImageViewController
            //Create empty FlickrImage record
            var imgRecord = FlickrImage()
            let imageCell : FlickrImageCollectionViewCell = sender as! FlickrImageCollectionViewCell
            if let row = self.collectionView?.indexPath(for: imageCell)?.row {
                //find selected collection view cell row to fetch corresponding record
                imgRecord = self.flickrImages[(row)]
            }
            imageViewController.imageDetails = imgRecord
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.flickrImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        if cell is FlickrImageCollectionViewCell {
            let imgCell = cell as! FlickrImageCollectionViewCell
            let feed = self.flickrImages[indexPath.row]
            if let mediaLink = feed.media {
                if let imgURL = URL(string: mediaLink) {
                    imgCell.flickrImgView?.af_setImage(withURL: imgURL, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                }
            }
            else
            {
                imgCell.flickrImgView?.image = #imageLiteral(resourceName: "placeholder")
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    func fetchImages(flickrLink:String) {
       let flickrImageFetcher = FlickrFeedFetcher()
        flickrImageFetcher.requestFlickr(withFeedLink: flickrLink) { [weak self] jsonResponse in
            
            if let json = jsonResponse {
                let jsonParser = FlickrJSONParser()
                self?.flickrImages = jsonParser.parse(withJSON: json)
            } else {
                self?.showAlert(withTitle: "Server Error", message: "Invalid response from server error!", actionTitle: "OK")
                self?.flickrImages = [FlickrImage]()
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                self?.collectionView?.reloadData()
            })
        }
    }
    
    func showAlert(withTitle title:String, message:String, actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
