//
//  StopRecordingView.swift
//  ChatRoomPostData
//
//  Created by sameapple on 2020/2/5.
//  Copyright © 2020 sameapple. All rights reserved.
//

import UIKit

protocol StopRecordingViewDelegate: NSObjectProtocol {
    
    func stopRecordingButtonClickAction(button: UIButton)
}

class StopRecordingView: UIView {

    @IBOutlet weak var progressBottomView: UIView!
    @IBOutlet weak var progressMarkView: UIView!
    @IBOutlet weak var progressTimeView: UIView!
    @IBOutlet weak var progressTimeViewWidth: NSLayoutConstraint!
    @IBOutlet var progressMarkViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var recordingTimeView: UIView!
    @IBOutlet weak var recordingPointView: UIView!
    @IBOutlet weak var recordingTimeLabel: UILabel!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var delegate: StopRecordingViewDelegate?
    
    var maxTimeValue: CGFloat = 30.0
    let filterViewModel = FilterCameraViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    func loadXib() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "StopRecordingView", bundle: bundle)
        //透過nib來取得xibView
        let xibView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        xibView.frame = self.frame
        addSubview(xibView)
        //設定xibView的Constraint
        
//        if kScreenWidth >= 414 { //plus width = 414
//            progressMarkViewLeading.constant = 98
//        } else {
            progressMarkViewLeading.constant = (kScreenWidth/30)*10
//        }
        
        initViewModel()
    }
    
    func initViewModel() {
        
        FilterCameraViewModel.shared.progressSetPresent = { [weak self] (time)  in
            DispatchQueue.main.async {
                self!.recordingTimeLabel.text = String(format: "%d sec.", Int(time))
                UIView.animate(withDuration: 0.1, animations: {
                    
                    self!.progressTimeViewWidth.constant = kScreenWidth/self!.maxTimeValue*CGFloat(time)
                    self!.layoutIfNeeded()
                }, completion: nil)
                
                if time < 10.000 {
                    self!.progressTimeView.backgroundColor = c25515596
                } else {
                    self!.progressTimeView.backgroundColor = c221106144
                }
            }
        }
        
        startRecordingPointAnimation()
    }
    
    func startRecordingPointAnimation() {
        
        UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                self.recordingPointView.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0) {
                self.recordingPointView.alpha = 1.0
            }
            //self.layoutIfNeeded()
        }, completion: nil)
    }
    
    //停止錄影按鈕
    @IBAction func stopRecordingButtonAction(_ sender: UIButton) {
        if stopRecordingButton.tag == 0 {
            stopRecordingButton.tag = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                self.stopRecordingButton.tag = 0
            }
            if delegate != nil {
                delegate?.stopRecordingButtonClickAction(button: sender)
            }
        }
    }
}
