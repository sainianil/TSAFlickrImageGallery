//
//  FlickrImageViewController.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/17/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import UIKit

/**
 * FlickrImageViewController: The purpose of this controller class is to present image with metadata information.
 * User will tap on any image in collection view that image and image info is presented by this controller view.
 */

class FlickrImageViewController: UIViewController {
    @IBOutlet weak var flickrImageView: UIImageView?
    @IBOutlet weak var flickrImageTitle: UILabel!
    @IBOutlet weak var flickrAuthor: UILabel!
    @IBOutlet weak var flickrAuthorId: UILabel!
    @IBOutlet weak var flickrLink: UILabel!
    @IBOutlet weak var flickrMedia: UILabel!
    @IBOutlet weak var flickrPublished: UILabel!
    @IBOutlet weak var flickrTags: UILabel!
    @IBOutlet weak var flickrDateTaken: UILabel!
    @IBOutlet weak var flickrDescription: UILabel!
    
    var imageDetails: FlickrImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flickrImageView?.af_setImage(withURL: URL(string:(imageDetails?.media)!)!, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        flickrImageTitle.text = imageDetails?.title
        flickrAuthor.text = imageDetails?.author
        flickrAuthorId.text = imageDetails?.authorId
        flickrLink.text = imageDetails?.link
        flickrMedia.text = imageDetails?.media
        flickrPublished.text = imageDetails?.published
        flickrTags.text = imageDetails?.tags
        flickrDateTaken.text = imageDetails?.dateTaken
        flickrDescription.text = imageDetails?.imageDesc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
