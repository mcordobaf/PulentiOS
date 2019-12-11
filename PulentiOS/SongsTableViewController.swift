//
//  SongsTableViewController.swift
//  PulentiOS
//
//  Created by t on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit
import SwiftyJSON

class SongsTableViewController: UITableViewController {

    var termSearched:String!
    var listSearched:[ItunesModel]!
    
    private var dataSaved:DataSaved = DataSaved.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "tableViewSongs"
        let data:Data? = dataSaved.getSearchByTermAlreadyExists(term: termSearched)
        do {
            let json:JSON = getJsonFromData(data: data!)
            
            listSearched = try JSONDecoder().decode([ItunesModel].self, from: json["results"].rawString()!.data(using: String.Encoding.utf8)!)
            
        }
        catch {
            print(error)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func getJsonFromData(data:Data) -> JSON {
        return JSON.init(parseJSON: String(decoding: data, as: UTF8.self))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listSearched!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = listSearched[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSong", for: indexPath) as! SongSearchedTableViewCell
        
        cell.accessibilityIdentifier = "cellSong_\(indexPath.row)"
        cell.artistName.text = "Artist: " + song.artistName!
        cell.albumName.text = "Album: " + song.collectionCensoredName!
        cell.songName.text = "Song: " + song.trackName!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let albumViewController:AlbumViewController = navigationController!.storyboard!.instantiateViewController(withIdentifier: "albumController") as! AlbumViewController
        albumViewController.itunesModel = listSearched[indexPath.item]
        navigationController!.pushViewController(albumViewController, animated: true)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
