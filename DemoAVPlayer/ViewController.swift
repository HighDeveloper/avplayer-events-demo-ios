import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    let avpController = AVPlayerViewController()
    var startEventIsActivate = false
    var playEventIsActivate = false
    var pausetEventIsActivate = false
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: path!))
        player = AVPlayer(playerItem: playerItem)
        
        self.avpController.player = self.player
        avpController.view.frame = viewPlayer.frame
        self.addChildViewController(avpController)
        self.view.addSubview(avpController.view)
        
        initStartEventListener()
        initPlayEventListener()
        initPauseEventListener()
        initFinishEventListener()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initStartEventListener() {
        if !startEventIsActivate && !playEventIsActivate && !pausetEventIsActivate {
            player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), options: [.old, .new], context: nil)
        }
        startEventIsActivate = true
    }
    
    func initPlayEventListener() {
        if !startEventIsActivate && !playEventIsActivate && !pausetEventIsActivate {
            player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), options: [.old, .new], context: nil)
        }
        playEventIsActivate = true
    }
    
    func initPauseEventListener() {
        if !startEventIsActivate && !playEventIsActivate && !pausetEventIsActivate {
            player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), options: [.old, .new], context: nil)
        }
        pausetEventIsActivate = true
    }
    
    func initFinishEventListener() {
        NotificationCenter.default.addObserver(self, selector:#selector(playerDidFinishPlaying(note:)), name: .AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
    }
    
    override func observeValue(forKeyPath keyPath: String?,of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(AVPlayer.rate) {
            
            let newStatus = change?[.newKey] as? NSNumber
            
            if newStatus == 1 {
                if startEventIsActivate {
                    informationLabel.text = "start event"
                    startEventIsActivate = false
                } else if playEventIsActivate {
                    informationLabel.text = "play event"
                }
            } else if newStatus == 0{
                if pausetEventIsActivate {
                    informationLabel.text = "pause event"
                }
            }
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        informationLabel.text = "Video Finished"
    }
    
}

