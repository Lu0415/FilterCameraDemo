//
//  FilterCameraViewController.swift
//  ChatRoomPostData
//
//  Created by sameapple on 2020/2/5.
//  Copyright © 2020 sameapple. All rights reserved.
//

import UIKit

import AVKit
import AssetsLibrary



class FilterCameraViewController: UIViewController, CameraFunctionViewDelegate, StopRecordingViewDelegate {
    
//    //MARK: - 圖片裁切相關
    var getImage: UIImage!
//    //裁切框移類型 (move圖片移動, stay裁切框移動)
//    public var clipperType: DynamicClipperType = .Move
//
//    lazy var clippedImageView: UIImageView? = {
//
//        let clippedImageView = UIImageView(frame: CGRect(x: 20, y: 300, width: 320, height: 320))
//        clippedImageView.backgroundColor = .black
//
//        return clippedImageView
//    }()
    
    var myCameraViewHandler: CGECameraViewHandler!
    var timerSchedule: Timer?
    var movieUrl: URL!
    var movieData: Data!
    var bottomSaveArea: CGFloat = 0.0
    var isFlashOn: Bool = false
    var isPhotoMode: Bool = true
    var selectedFilterIndex: Int = 0
    var isCountdown: Bool = false
    var recordTime: Double = 0
    var canTakePhoto: Bool = false
    
    lazy var glkView: GLKView = { [unowned self] in
        let glkView = GLKView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        return glkView
    }()
    
    lazy var cameraFunctionView: CameraFunctionView = { [unowned self] in
        let funcView = CameraFunctionView(frame: view.bounds, bottomSaveAreaHeight: bottomSaveArea)
        funcView.delegate = self
        return funcView
    }()
    
    lazy var stopRecordingView: StopRecordingView = { [unowned self] in
        let stopView = StopRecordingView(frame: view.bounds)
        stopView.delegate = self
        stopView.isHidden = true
        return stopView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilterCameraViewModel.shared.getAdjustArray()
        
        if #available(iOS 11.0, *) {
            bottomSaveArea = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        }
        
        movieUrl = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/Movie.mp4")
        
        myCameraViewHandler = CGECameraViewHandler.init(glkView: glkView)
        myCameraViewHandler.fitViewSizeKeepRatio(true)
        myCameraViewHandler.cameraRecorder.setPictureHighResolution(false)
        
        if myCameraViewHandler.setupCamera(AVCaptureSession.Preset.iFrame1280x720.rawValue, cameraPosition: AVCaptureDevice.Position.front, isFrontCameraMirrored: true, authorizationFailed: {
            //沒開權限
            self.toOutsideSettingOpenCameraAndMic()
        }) {
            //success
            myCameraViewHandler.cameraDevice()?.startCameraCapture()
            view.addSubview(glkView)
        }
        
        //MARK 顯示相機功能view
        view.addSubview(cameraFunctionView)
        
        //MARK 顯示停止錄影view
        view.addSubview(stopRecordingView)
        
        myCameraViewHandler.enableFaceBeautify(true)
        
        // 權限 AlertView 按鈕點擊事件
        FilterCameraViewModel.shared.closeAuthorityAlertView = { [weak self] ()  in
            self!.exitFilterCamera()
        }
        
        FilterCameraViewModel.shared.postDynamicCloseFilterCamera = { [weak self] (shouldClose) in
            if shouldClose {
                self!.dismiss(animated: false, completion: nil)
            }
        }
        
        FilterCameraViewModel.shared.changeFilterEffect = { [self] (effectConfig)  in
            self.myCameraViewHandler.setFilterWithConfig(effectConfig)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        MainTabbarViewModel.shared.sendScreenshotRecord(id: "", screenshotMode: 1, targetPage: className, targetMultimediaID: 0)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadViewDataWithFilterCamera(noti:)), name: .reloadViewDataWithFilterCamera, object: nil)
    }
    
//    //MARK: 重新連線後刷新頁面
//    @objc func reloadViewDataWithFilterCamera(noti: Notification) {
//        exitFilterCamera()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: .reloadViewDataWithFilterCamera, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 2.1, repeats: false) { (timer) in
            self.canTakePhoto = true
        }
    }
    
    //MARK 相機功能
    func functionButtonClickAction(button: UIButton) {
        switch button.tag {
        case 1: //濾鏡
            break
        case 2: //美肌
            beautyFaceEnable()
            break
        case 3: //倒數計時
            isCountdown = button.isSelected ? false : true
            break
        case 4: //切換鏡頭
            switchCamera()
            break
        case 5: //閃光燈
            flashStatus(selected: button.isSelected)
            break
        default: //離開
            exitFilterCamera()
            break
        }
    }
    
    //MARK: 開始錄影
    func buttonLongPressAction() {
        if canTakePhoto {
            if isCountdown { //要倒數
                FilterCameraViewModel.shared.countdownViewHidden = false
                FilterCameraViewModel.shared.countdownNumber = 0
                countdownSchedule(repeats: true, runtime: 1, second: 3, isTakePhoto: false)
            } else {
                startRecord()
            }
        }
    }
    
    //MARK: 拍照事件
    func recordButtonClickAction(button: UIButton) {
        
        if isCountdown { //要倒數
            FilterCameraViewModel.shared.countdownViewHidden = false
            FilterCameraViewModel.shared.countdownNumber = 0
            countdownSchedule(repeats: true, runtime: 1, second: 3, isTakePhoto: true)
        } else {
            takePhoto()
        }
    }
    
    func countdownSchedule(repeats: Bool, runtime: TimeInterval, second: Int, isTakePhoto: Bool) {
        var count = second
        timerSchedule = Timer.scheduledTimer(withTimeInterval: runtime, repeats: repeats, block: { (_) in
            if count == 0 {
                self.stopTimer()
                FilterCameraViewModel.shared.countdownViewHidden = true
                if isTakePhoto {
                    self.takePhoto()
                } else {
                    self.startRecord()
                }
            } else {
                FilterCameraViewModel.shared.countdownNumber = count
                count -= 1
            }
        })
    }
    
    //MARK: 取消倒數
    func countdownButtonClickAction(button: UIButton) {
        FilterCameraViewModel.shared.countdownViewHidden = true
        stopTimer()
    }
    
    //MARK: 停止timer
    func stopTimer() {
        if timerSchedule != nil {
            timerSchedule!.invalidate()
            timerSchedule = nil
        }
    }
    
    //MARK: 執行拍照方法
    func takePhoto() {
        /*
         * 因美肌為獨立功能所以先執行一般拍照方法takePicture套濾鏡，
         * 之後再執行螢幕拍照takeShot套上美肌效果，takePicture才有辦法控制閃光燈
         */
        FilterCameraViewModel.shared.isPhoto = true
        //一般拍照方法套濾鏡
        do {
            myCameraViewHandler.takePicture({ (image) in
                //美顏濾鏡拍照方法
                self.myCameraViewHandler.takeShot { (image) in
                    if image != nil {
                        self.getImage = image
                        //print("拍照成功")
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "ShowPreviewViewController", sender: self)
                        }
                    } else {
                        //取得照片失敗
                    }
                }
            }, filterConfig: try get_effectConfig.cStringArray().pointer[selectedFilterIndex], filterIntensity: 1.0, isFrontCameraMirrored: true)
        } catch {
            //濾鏡參數轉換錯誤
            print("濾鏡參數轉換錯誤")
        }
    }
    
    //MARK: 開始綠影
    func startRecord() {
        
        cameraFunctionView.isHidden = true
        stopRecordingView.isHidden = false
        FilterCameraViewModel.shared.isPhoto = false
        
        if isFlashOn {
            myCameraViewHandler.setTorchMode(.on)
        } else {
            myCameraViewHandler.setTorchMode(.off)
        }
        
        unlink(movieUrl.path)
        myCameraViewHandler.startRecording(movieUrl, size: CGSize(width: RECORD_WIDTH, height: RECORD_HEIGHT))
        
        DispatchQueue.main.async {
            self.timerSchedule = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (_) in
                self.recordTime += 0.1
                FilterCameraViewModel.shared.progressTime = Float(self.recordTime)
                
                //30秒到了
                if Int(self.recordTime) == 30 {
                    self.stopTimer()
                    self.myCameraViewHandler.endRecording({
                        self.stopRecording()
                    }, withCompressionLevel: 0)
                }
            })
        }
    }
    
    //MARK: 停止錄影按鈕事件
    func stopRecordingButtonClickAction(button: UIButton) {
        self.stopTimer()
        self.myCameraViewHandler.endRecording({
            self.stopRecording()
        }, withCompressionLevel: 0)
    }
    
    //MARK: 停止錄影
    func stopRecording() {
        DispatchQueue.main.async {
            self.cameraFunctionView.isHidden = false
            self.stopRecordingView.isHidden = true
            
            self.myCameraViewHandler.setTorchMode(.off)
            
            if self.recordTime < 10.0 { //不足10秒
//                self.showNotEnoughtTimeView()
            } else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowPreviewViewController", sender: self)
                }
            }
            self.recordTime = 0.0
            FilterCameraViewModel.shared.progressTime = 0.0
        }
    }
    
    //segue頁面跳轉
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == SegueID.toDynamicCoverCropView {
//            DispatchQueue.main.async {
//                if let destinationVC = segue.destination as? DynamicCoverCropViewController {
//                    destinationVC.setBaseImg(self.getImage, resultImgSize: (self.clippedImageView?.frame.size)!, type: self.clipperType)
//                }
//            }
//        }
        
        if segue.identifier == "ShowPreviewViewController" {
            if let destinationVC = segue.destination as? PreviewViewController {
                if FilterCameraViewModel.shared.isPhoto {
                    destinationVC.photoData = self.getImage.pngData()
                } else {
                    destinationVC.videoUrl = movieUrl
                }
            }
        }
        
//        if segue.identifier == UnwindID.unwindToChataRoomViewController {
//            self.navigationController?.reveal()
//            self.navigationController?.popViewController(animated: false)
//        }
    }
    
    //MARK: 濾鏡選擇
    func filterSelectedIndex(index: Int) {
        selectedFilterIndex = index
        myCameraViewHandler.setFilterWithConfig(get_effectConfig[index])
    }
    
    //MARK: 美顏開關
    func beautyFaceEnable() {
        if myCameraViewHandler.isGlobalFilterEnabled() {
            myCameraViewHandler.enableFaceBeautify(false)
        } else {
            myCameraViewHandler.enableFaceBeautify(true)
        }
    }
    
    //MARK: 切換鏡頭
    func switchCamera() {
        //Pass true to mirror the front camera.
        myCameraViewHandler.switchCamera(true)
        
        if myCameraViewHandler.cameraPosition().rawValue == 2 {
            FilterCameraViewModel.shared.flashButtonHidden = true
        } else {
            FilterCameraViewModel.shared.flashButtonHidden = false
            isFlashOn = false
        }
    }
    
    //MARK: 閃光燈開關
    func flashStatus(selected: Bool) {
        
        if selected {
            isFlashOn = false
            if isPhotoMode {
                myCameraViewHandler.setCameraFlashMode(.off)
            }
        } else {
            isFlashOn = true
            if isPhotoMode {
                myCameraViewHandler.setCameraFlashMode(.on)
            }
        }
    }
    
    //MARK: 離開相機
    func exitFilterCamera() {
        
//        if FilterCameraViewModel.shared.isFromChatRoom {
//            self.performSegue(withIdentifier: UnwindID.unwindToChataRoomViewController, sender: self)
//        } else {
//            self.dismiss(animated: true, completion: nil)
//        }
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.dismiss(animated: true) {
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        self.viewAnimations(isOpen: true)
    }
    
//    //MARK: 顯示不足10秒提示
//    func showNotEnoughtTimeView() {
//        DispatchQueue.main.async {
//            let window = UIWindow.key
//            let notEnoughTimeView = NotEnoughTimeView(frame: window!.bounds)
//            notEnoughTimeView.tag = AlertTag.notEnoughTimeView
//            if FilterCameraViewModel.shared.isFromChatRoom {
//                notEnoughTimeView.titleLabel.text = "900112"
//            } else {
//                notEnoughTimeView.titleLabel.text = "1170189"
//            }
//            notEnoughTimeView.delegate = self
//            window!.addSubview(notEnoughTimeView)
//        }
//    }
    
    //MARK: 關閉提示
    func closeNotEnoughTimeViewAction(button: UIButton) {
//        closeWindowTipView(tag: AlertTag.notEnoughTimeView)
    }
    
    //MARK: 關閉選單畫面
    func closeWindowTipView(tag: Int) {
        if let window = UIWindow.key {
            window.viewWithTag(tag)?.removeFromSuperview()
        }
    }
    
    //MARK: 隱藏StatusBar
    override var childForStatusBarHidden: UIViewController? {
        return children.first
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func unwindToFilterCameraViewController(segue: UIStoryboardSegue) {}
}
