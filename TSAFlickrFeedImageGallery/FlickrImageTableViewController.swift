//
//  FlickrImageTableViewController.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/18/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import UIKit

/*
 * FlickrImageTableViewController - This class will display the image and its meta data
 */

class FlickrImageTableViewController: UITableViewController {

    //Cell identifier
    private let reuseIdentifier = "ImageDetailsCell"
    var imageDetails: FlickrImage?

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var flickrImageView: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Toolbar
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        //set variable cell size
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 40
        
        //set asychronously image to imageView, if there is no image set the placeholder
        flickrImageView?.af_setImage(withURL: URL(string:(imageDetails?.media)!)!, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //set no. of row to number of keys in imageDetails otherwise default value to 0
        return (imageDetails?.jsonKeys().count) ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let detailCell = cell as? FlickrImageDetailTableViewCell {
            //Retrive and set value of image detail key
            let jsonKey = imageDetails?.jsonKeys()[indexPath.row]
            detailCell.titleLabel.text = jsonKey
            //fetch image detail value for the json key and set its value in subTitle
            detailCell.detailLabel.text = imageDetails?.jsonValue(forKey: jsonKey!)
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    * shareFlickrImages - Open share drawer to share image
    */
    @IBAction func shareFlickrImages(_ sender: UIBarButtonItem) {
        let shareImage = self.flickrImageView?.image
        //Share image if image is nil, try to share link if link is also nil, will share placeholder image
        let activityViewController = UIActivityViewController(
            activityItems: ["Check out this Image I think you might like it! \(imageDetails?.media! ?? "")", shareImage ?? #imageLiteral(resourceName: "placeholder")], applicationActivities: nil)
        
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.barButtonItem = sender
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
}
