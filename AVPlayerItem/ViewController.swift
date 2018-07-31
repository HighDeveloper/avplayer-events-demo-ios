import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var avpController = AVPlayerViewController()
    var startEventIsActivate = false
    var playEventIsActivate = false
    var pausetEventIsActivate = false
    @IBOutlet weak var viewPlayer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // For external videos
        playerItem = AVPlayerItem(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
        player = AVPlayer(playerItem: playerItem)
        // end external videos code
        
        /*
        // For internal videos use
        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: path!))
        player = AVPlayer(playerItem: playerItem)
        // end internal videos code
        */
        
        self.avpController.player = self.player
        avpController.view.frame = viewPlayer.frame
        self.addChildViewController(avpController)
        self.view.addSubview(avpController.view)
        
        startEventTrigger()
        playEventTrigger()
        pauseEventTrigger()
        finishEventTrigger()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startEventTrigger() {
        if !startEventIsActivate && !playEventIsActivate && !pausetEventIsActivate {
            player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), options: [.old, .new], context: nil)
        }
        startEventIsActivate = true
    }
    
    func playEventTrigger() {
        if !startEventIsActivate && !playEventIsActivate && !pausetEventIsActivate {
            player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), options: [.old, .new], context: nil)
        }
        playEventIsActivate = true
    }
    
    func pauseEventTrigger() {
        if !startEventIsActivate && !playEventIsActivate && !pausetEventIsActivate {
            player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), options: [.old, .new], context: nil)
        }
        pausetEventIsActivate = true
    }
    
    func finishEventTrigger() {
        NotificationCenter.default.addObserver(self, selector:#selector(playerDidFinishPlaying(note:)), name: .AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
    }
    
    override func observeValue(forKeyPath keyPath: String?,of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(AVPlayer.rate) {
            
            let newStatus = change?[.newKey] as? NSNumber
            
            if newStatus == 1 {
                if startEventIsActivate {
                    print("start event")
                    startEventIsActivate = false
                } else if playEventIsActivate {
                    print("play event")
                }
            } else if newStatus == 0{
                if pausetEventIsActivate {
                    print("pause event")
                }
            }
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        print("Video Finished")
    }
    
}

