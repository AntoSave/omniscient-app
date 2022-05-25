//
//  CameraController.swift
//  omniscient
//
//  Created by Antonio Langella on 29/04/22.
//

import Foundation
import UIKit

class CameraController: UIViewController,VLCMediaPlayerDelegate,VLCMediaThumbnailerDelegate{
    func mediaThumbnailerDidTimeOut(_ mediaThumbnailer: VLCMediaThumbnailer!) {
        print("time out")
    }
    func mediaThumbnailer(_ mediaThumbnailer: VLCMediaThumbnailer!, didFinishThumbnail thumbnail: CGImage!) {
        print("okok")
        image.image=UIImage(cgImage: thumbnail)
    }
    
    @IBOutlet weak var movieView: UIView!

    @IBOutlet weak var image: UIImageView!
    // Enable debugging
    //var mediaPlayer: VLCMediaPlayer = VLCMediaPlayer(options: ["-vvvv"])
    var mediaPlayer: VLCMediaPlayer?
    //var mediaThumbnailer: VLCMediaThumbnailer?
    var hasTakenSnapshot: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did load")
        mediaPlayer = VLCMediaPlayer(options: ["--rtsp-tcp"]) //NOTA:  --rtsp-tcp forza l'uso di tcp. Questo permette di risolvere un bug relativo all'assenza di ack da parte del client che comportava la chiusura della connesisone rtsp dopo circa 30 secondi a causa della scadenza del timeout. Potrebbe non essere necessario per alcuni modelli di telecamere. NON rimuovere!
        //mediaPlayer!.libraryInstance.debugLogging = true
        //mediaPlayer!.libraryInstance.debugLoggingLevel = 3

        //Add rotation observer
        /*NotificationCenter.default.addObserver(
            self,
            selector: #selector(CameraController.rotated),
            name: NSNotification.Name.UIDevice.orientationDidChangeNotification,
            object: nil)*/
        
        //Setup movieView
        self.movieView.backgroundColor = UIColor.gray
        //self.movieView.frame = UIScreen.screens[0].bounds

        //Add tap gesture to movieView for play/pause
        let gesture = UITapGestureRecognizer(target: self, action: #selector(CameraController.movieViewTapped(_:)))
        self.movieView.addGestureRecognizer(gesture)

        //Add movieView to view controller
        //self.view.addSubview(self.movieView)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        print("Did appear")
        //Playing multicast UDP (you can multicast a video from VLC)
        //let url = NSURL(string: "udp://@225.0.0.1:51018")
        //Playing HTTP from internet
        //let url = NSURL(string: "http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4")
        //Playing RTSP from internet
        //let url = URL(string: "rtsp://admin:password@192.168.1.74:554/live/ch0")
        let url = URL(string: "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4")
        if url == nil {
            print("Invalid URL")
            return
        }

        let media = VLCMedia(url: url!)

        // Set media options
        // https://wiki.videolan.org/VLC_command-line_help
        //media.addOptions([
        //    "network-caching": 300
        //])
        mediaPlayer!.media = media

        mediaPlayer!.delegate = self
        mediaPlayer!.drawable = self.movieView
        
        //mediaThumbnailer = VLCMediaThumbnailer(media: media, andDelegate: self)
        //mediaThumbnailer!.fetchThumbnail()
        mediaPlayer?.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
        mediaPlayer!.stop()
        print("Will disappear")
    }
    override func didReceiveMemoryWarning() {
        print("WARNING!!!!!!")
        super.didReceiveMemoryWarning()
    }
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        print("STATE CHANGED: ", aNotification!)
    }
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        /*print("TIME CHANGED: ", aNotification!)
        if(!hasTakenSnapshot && mediaPlayer!.hasVideoOut){
            print("Snapshot taken")
            hasTakenSnapshot = true
            let tmpDirURL = FileManager.default.temporaryDirectory
            let path = tmpDirURL.appendingPathComponent("snapshot")
            mediaPlayer!.saveVideoSnapshot(at: path.path, withWidth: 0, andHeight: 0)
            
            image.image=UIImage(contentsOfFile: path.path)
        }*/
    }
    @objc func rotated() {

        let orientation = UIDevice.current.orientation

        if (orientation.isLandscape) {
            print("Switched to landscape")
        }
        else if(orientation.isPortrait) {
            print("Switched to portrait")
        }

        //Always fill entire screen
        self.movieView.frame = self.view.frame

    }

    @objc func movieViewTapped(_ sender: UITapGestureRecognizer) {

        if mediaPlayer!.isPlaying {
            mediaPlayer!.pause()

            let remaining = mediaPlayer!.remainingTime
            let time = mediaPlayer!.time

            print("Paused at \(time?.stringValue ?? "nil") with \(remaining?.stringValue ?? "nil") time remaining")
        }
        else {
            mediaPlayer!.play()
            print("Playing")
        }
        
    }
    
}
