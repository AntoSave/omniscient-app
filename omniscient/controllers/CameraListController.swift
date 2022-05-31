//
//  MainController.swift
//  omniscient
//
//  Created by Antonio Langella on 24/04/22.
//

import UIKit
import CoreData

class CameraListController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var cameraTableView: UITableView!
    let cellReuseIdentifier = "cameraCell"
    let context = PersistanceController.shared.container.viewContext
    var cameraList: [Camera] {
        let fetchRequest = Camera.fetchRequest()
        let cameras = try! context.fetch(fetchRequest)
        return cameras
    }
    
    @IBOutlet weak var test: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.staticDataUpdated, object: nil)

        
        self.cameraTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cameraTableView.dataSource = self
        cameraTableView.delegate = self
    }
    //Restituisce il numero di righe per ogni sezione
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //Funzione generatrice di righe
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CameraCell = self.cameraTableView
            .dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! CameraCell
        //cell.setTitle(title: cameraList[indexPath.section].name!)
        //cell.setPreviewImage(fromUrl:"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4")
        cell.setCamera(camera: cameraList[indexPath.section])
        return cell
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return cameraList.count
    }
    //Funzione chiamata al click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //Funzione chiamata prima del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cameraVC = segue.destination as? CameraController {

            //cameraVC.link="ciao"
           }
    }
    
    @objc func contextObjectsDidChange(_:Any){
        print("contextObjectDidChange!!!!!!!!!!!!!!")
        DispatchQueue.main.async {
            self.cameraTableView.reloadData()
        }
    }
}
//Riga personalizzata
class CameraCell: UITableViewCell,VLCMediaThumbnailerDelegate{
    @IBOutlet weak var cameraTitle: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var camera: Camera? = nil
    
    required init(coder decoder: NSCoder){
        super.init(coder: decoder)!
    }
    public func setTitle(title: String){
        self.cameraTitle.text = title
    }
    public func setPreviewImage(img: UIImage){
        activityIndicator.stopAnimating()
        previewImage.alpha = 1
        previewImage.image = img
    }
    public func setCamera(camera: Camera){
        self.camera = camera
        setTitle(title: camera.name!)
        activityIndicator.startAnimating()
        if let imgData = camera.thumbnail, let date = camera.thumbnailDate, Date.now < date.addingTimeInterval(3600*2) {
            setPreviewImage(img: UIImage(data: imgData)!)
            print("Preview set from storage")
        }
        else {
            setPreviewImage(fromUrl: camera.domain!)
            print("Preview set from fetch")
        }
    }
    public func setPreviewImage(fromUrl urlString: String){
        let url = URL(string: urlString)
        if url == nil {
            print("Invalid URL")
            return
        }
        let media = VLCMedia(url: url!)
        let thumbnailer = VLCMediaThumbnailer(media: media, andDelegate: self)
        thumbnailer?.fetchThumbnail()
    }
    
    func mediaThumbnailerDidTimeOut(_ mediaThumbnailer: VLCMediaThumbnailer!) {
        print("Error in getting thumbnail!")
    }
    
    func mediaThumbnailer(_ mediaThumbnailer: VLCMediaThumbnailer!, didFinishThumbnail thumbnail: CGImage!) {
        activityIndicator.stopAnimating()
        previewImage.alpha = 1
        previewImage.image = UIImage(cgImage: thumbnail)
        if let camera = camera {
            camera.thumbnailDate = Date.now
            camera.thumbnail = previewImage.image?.pngData()
            try! camera.managedObjectContext?.save()
        }
    }
}


