//
//  CameraController.swift
//  omniscient
//
//  Created by Antonio Langella on 29/04/22.
//

import Foundation
import UIKit

class CameraController: UIViewController,VLCMediaPlayerDelegate{
    @IBOutlet weak var movieView: UIView!

    // Enable debugging
    //var mediaPlayer: VLCMediaPlayer = VLCMediaPlayer(options: ["-vvvv"])
    var mediaPlayer: VLCMediaPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did load")
        mediaPlayer = VLCMediaPlayer()
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
        let url = URL(string: "rtsp://admin:password@192.168.1.73:554/live/ch0")

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

    }
    override func viewWillDisappear(_ animated: Bool) {
        mediaPlayer!.stop()
        print("Will disappear")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
