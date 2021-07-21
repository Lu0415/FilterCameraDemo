//
//  PreviewViewController.swift
//  CGECameraDemo
//
//  Created by 盧彥辰 on 2021/7/19.
//

import UIKit
import AVKit
import Photos

class PreviewViewController: UIViewController {

    var photoData: Data!
    
    var videoUrl: URL!
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    private var avPlayer: AVPlayer = AVPlayer()
    private var avPlayerLayer: AVPlayerLayer = AVPlayerLayer()
    private var avPlayerItem: AVPlayerItem!
    private var avPlayerAsset: AVURLAsset!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if FilterCameraViewModel.shared.isPhoto {
            previewImageView.image = UIImage(data: photoData)
        } else {
//            showLoadingView()
            avPlayerItem = AVPlayerItem(url: videoUrl)
            avPlayerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
            avPlayerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
            avPlayer = AVPlayer(playerItem: self.avPlayerItem)
            avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
            previewImageView.layer.insertSublayer(self.avPlayerLayer, at: 0)
            self.avPlayerLayer.frame = self.view.frame
            avPlayerLayer.videoGravity = .resizeAspect
            self.avPlayer.play()
            
        }
    }
    
    //MARK: 影片讀取狀態
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else { return }
        
        if keyPath == "loadedTimeRanges" {
            print("緩衝中")
        } else if keyPath == "status" {
            if playerItem.status == .readyToPlay {
                print("可以播放")
                playVideo()
            } else {
                print("加載失敗")
            }
        }
    }
    
    //MARK: 開始播放
    func playVideo() {
        DispatchQueue.main.async {
            self.avPlayer.play()
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem, queue: nil) { (_) in
                self.avPlayer.seek(to: CMTime.zero)
                self.avPlayer.play()
            }
        }
    }
    
    // MARK: 移除AVPlayer監聽
    func removeAVPlayerObserver() {
        if FilterCameraViewModel.shared.isPhoto == false {
            if avPlayerItem != nil {
                self.avPlayer.replaceCurrentItem(with: nil)
                avPlayerItem.removeObserver(self, forKeyPath: "status", context: nil)
                avPlayerItem.removeObserver(self, forKeyPath: "loadedTimeRanges", context: nil)
            }
        }
    }
    
    //離開
    @IBAction func exitButtonAction(_ sender: UIButton) {
        removeAVPlayerObserver()
        self.dismiss(animated: true) {
            
        }
    }
    

}
