//
//  AlbumViewController.swift
//  PulentiOS
//
//  Created by Marco Cordoba Fernandez on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit
import SwiftyJSON

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RequestListener {

    @IBOutlet var imageViewAlbum: UIImageView!
    @IBOutlet var labelAlbum: UILabel!
    @IBOutlet var labelArtistName: UILabel!
    @IBOutlet var tableViewSongsAlbum: UITableView!

    var itunesModel:ItunesModel?
    var jsonAlbum:JSON?
    
    private let itunesDAO:ItunesDAO = ItunesDAO.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSongsAlbum.accessibilityIdentifier = "tableViewSongsAlbum"
        
        labelAlbum.text = "Album: " + itunesModel!.collectionCensoredName!
        labelArtistName.text = "Artist: " + itunesModel!.artistName!
        
        let url = URL(string: itunesModel!.artworkUrl100!)
        let data = try? Data(contentsOf: url!)
        imageViewAlbum.image = UIImage(data: data!)
        
        itunesDAO.searchSongsByAlbum(collectionId: itunesModel!.collectionId!, listener: self)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSongAlbum", for: indexPath)
        if (jsonAlbum != nil){
            cell.textLabel?.text = jsonAlbum!["results"].array![indexPath.row]["trackName"].stringValue
            cell.accessibilityIdentifier = "cellSongAlbum_\(indexPath.row)"
        }
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of rows
        if (jsonAlbum != nil){
            return jsonAlbum!["resultCount"].intValue
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = jsonAlbum!["results"].array![indexPath.row]["previewUrl"].stringValue
        let songName = jsonAlbum!["results"].array![indexPath.row]["trackName"].stringValue
        showPreview(url: url, songName: songName)
    }
    
    private func showPreview(url:String, songName:String){
        let previewSongViewController = navigationController!.storyboard!.instantiateViewController(withIdentifier: "previewController") as! PreviewSongController
        previewSongViewController.url = url
        previewSongViewController.songName = songName
        
        previewSongViewController.view.layer.cornerRadius = 15.0
        
        previewSongViewController.modalPresentationStyle = .overCurrentContext
        previewSongViewController.modalTransitionStyle = .crossDissolve
        
        self.present(previewSongViewController, animated: true, completion:{})
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func respond(data: Data?) {
        do{
            jsonAlbum = try JSON.init(data: data!)
        }
        catch{
        }
        DispatchQueue.main.async() {
            self.tableViewSongsAlbum.reloadData()
        }
    }
    
    func error(error: Error) {
        
    }
    
   
}
