//
//  PreviewSongController.swift
//  PulentiOS
//
//  Created by Marco Cordoba Fernandez on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit
import AVKit

class PreviewSongController: UIViewController, RequestListener {

    private let itunesDAO:ItunesDAO = ItunesDAO.getInstance()
    var url:String!
    var songName:String!
    var audioPlayer : AVAudioPlayer?
    
    @IBOutlet var songNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songNameLabel.text = songName
        itunesDAO.downloadPreviewSong(url: url, listener: self)
    }
    
    @IBAction func playSong(_ sender: UIButton) {
        self.audioPlayer?.play()
    }
    
    @IBAction func stopSong(_ sender: UIButton) {
        self.audioPlayer?.stop()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func previewSongDownloaded(data: Data?) {
        DispatchQueue.main.async() {
            do{
                self.audioPlayer = try AVAudioPlayer(data: data!)
                self.audioPlayer?.prepareToPlay()
                
                
            }
            catch{
                print(error)
            }
        }
    }
    
    func respond(data: Data?) {
        previewSongDownloaded(data: data!)
    }
    
    func error(error: Error) {
        
    }
}

extension UIView {

    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
