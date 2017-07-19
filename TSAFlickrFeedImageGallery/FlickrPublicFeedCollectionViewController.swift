//
//  FlickrPublicFeedCollectionViewController.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/16/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import UIKit
import AlamofireImage
import MWPhotoBrowser
/**
 * FlickrPublicFeedCollectionViewController: Collection view controller show images fetched from flickr public feeds.
 */


class FlickrPublicFeedCollectionViewController: UICollectionViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIViewControllerPreviewingDelegate, MWPhotoBrowserDelegate {

    //Custom cell Identifier for UICollectionViewCell
    private let reuseIdentifier = "ImageCell"
    //Segue identifier of image details view controller
    private let showImageDetailsIdentifier = "ShowImageDetails"
    //Search bar cell identifier
    private let headerCellIdentifier = "FlickrSearchTagsCell"

    var searchController : UISearchController!
    var flickrImages = [FlickrImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //Search at the top
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        //make first responder
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
        
        //Register for 3DTouch
        if( traitCollection.forceTouchCapability == .available) {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        //request public feed
        let url = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
        self.fetchImages(flickrLink: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

   /* // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Check showImageDetailsIdentifier to show image detailed view to load
        if segue.identifier == showImageDetailsIdentifier {
            
        }
    } 
     */
 

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

        // check if the cell is of type FlickrImageCollectionViewCell
        if cell is FlickrImageCollectionViewCell {
            let imgCell = cell as! FlickrImageCollectionViewCell
            
            //Retrive image's feed
            let feed = self.flickrImages[indexPath.row]
            if let mediaLink = feed.media {
                if let imgURL = URL(string: mediaLink) {
                    //set image from image url
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openImageBrowser(index:UInt(indexPath.row))
    }
    
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
    
    // MARK: - UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController)
    {
         let flickrURL = "https://api.flickr.com/services/feeds/photos_public.gne?tags=searchTerm&;tagmode=any&format=json&nojsoncallback=1"
        let searchText = searchController.searchBar.text ?? ""
        if searchText != "" {
            let url = flickrURL.replacingOccurrences(of: "searchTerm", with: searchText)
            fetchImages(flickrLink: url)
        }
    }

    /*
     * fetchImages - This method fetches JSON data from given link, parses, store the data as FlickrImage in array and calls the reloadData of tableview on main thread to refresh the UI
     */
    func fetchImages(flickrLink:String) {
        //Create flickrImageFetcher object which will request for feeds
       let flickrImageFetcher = FlickrFeedFetcher()
        flickrImageFetcher.requestFlickr(withFeedLink: flickrLink) { [weak self] jsonResponse in
            
            //Verify jsonResponse for nil
            if let json = jsonResponse {
//                print(json)
                
                //Create FlickrJSONParser object
                let jsonParser = FlickrJSONParser()
                //jsonParser returns list of flickrImage objects
                self?.flickrImages = jsonParser.parse(withJSON: json)
            } else {
                //self?.showAlert(withTitle: "Server Error", message: "Invalid response from server error!", actionTitle: "OK")
                self?.flickrImages = [FlickrImage]()
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                self?.collectionView?.reloadData()
            })
        }
    }
    
    /*
     * showAlert - Display alert prompt with provided title, message and actionTitle
    */
    func showAlert(withTitle title:String, message:String, actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        //add action to alert
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openImageBrowser(index:UInt) {
        
        let browser = MWPhotoBrowser()
        browser.delegate = self
        
        // Set options
        browser.displayActionButton = true // Show action button to allow sharing, copying, etc (defaults to YES)
        browser.displayNavArrows = false // Whether to display left and right nav arrows on toolbar (defaults to NO)
        browser.displaySelectionButtons = false // Whether selection buttons are shown on each image (defaults to NO)
        browser.zoomPhotosToFill = true // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        browser.alwaysShowControls = false // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        browser.enableGrid = true // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        browser.startOnGrid = false // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        browser.autoPlayOnAppear = false // Auto-play first video
        browser.setCurrentPhotoIndex(index)
        
        self.navigationController?.pushViewController(browser, animated: true)
        browser.showNextPhoto(animated: true)
        browser.showPreviousPhoto(animated: true)
    }
    
    @IBAction func sortImagesByDateTaken(_ sender: UIBarButtonItem) {
        let sortedList : [FlickrImage] = flickrImages.sorted{ $0.dateTakenAsDate.compare($1.dateTakenAsDate) == .orderedAscending }
        //        print(sortedList)
        flickrImages = sortedList as [FlickrImage]
        self.collectionView?.reloadData()
    }
    
    @IBAction func sortImagesByDatePublished(_ sender: UIBarButtonItem) {
        let sortedList : [FlickrImage] = flickrImages.sorted { $0.publishedAsDate.compare($1.publishedAsDate) == .orderedAscending }
        //        print(sortedList)
        flickrImages = sortedList as [FlickrImage]
        self.collectionView?.reloadData()
    }
    
    // MARK: Trait collection delegate methods
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    // MARK: UIViewControllerPreviewingDelegate methods
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        //Using FlickrImageTableViewController as popview for 3D Touch
        guard let imageDetailTVC = storyboard?.instantiateViewController(withIdentifier: "FlickrImageTableViewController") as? FlickrImageTableViewController else { return nil }
        
        let imageDetail = self.flickrImages[indexPath.row]
        imageDetailTVC.imageDetails = imageDetail
        imageDetailTVC.preferredContentSize = CGSize(width: 0.0, height: 400)
        previewingContext.sourceRect = cell.frame
        
        return imageDetailTVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    // MARK: MWPhotoBrowserDelegate
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(self.flickrImages.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let feed = self.flickrImages[Int(index)]
        let mwPhoto = MWPhoto(url: URL(string: feed.media!))
        mwPhoto?.caption = feed.title
        return mwPhoto
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, actionButtonPressedForPhotoAt index: UInt) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let imgRecord = self.flickrImages[Int(index)]
        
        //Share action
        let shareAction = UIAlertAction(title: "Share", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let imgURL = URL.init(string: (imgRecord.media)!)
            let imgdata = try! Data.init(contentsOf: imgURL!)
            let shareImage = UIImage(data: imgdata)
            
            //Share image if image is nil, try to share link if link is also nil, will share placeholder image
            let activityViewController = UIActivityViewController(
                activityItems: ["Check out this Image I think you might like it! \(imgRecord.media ?? "")", shareImage ?? #imageLiteral(resourceName: "placeholder")], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        })
        
        //Meta Data action
        let metaDataAction = UIAlertAction(title: "Meta Data", style: .default, handler: { [weak self]
            (alert: UIAlertAction!) -> Void in
            //retrive FlickrImageViewController for segue
            if let imageDetailTVC = self?.storyboard?.instantiateViewController(withIdentifier: "FlickrImageTableViewController") as? FlickrImageTableViewController {
                imageDetailTVC.imageDetails = imgRecord
                self?.navigationController?.pushViewController(imageDetailTVC, animated: true)
            }
        })
        
        optionMenu.addAction(shareAction)
        optionMenu.addAction(metaDataAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}
