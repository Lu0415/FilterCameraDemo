//
//  CameraFunctionView.swift
//  ChatRoomPostData
//
//  Created by sameapple on 2020/2/5.
//  Copyright © 2020 sameapple. All rights reserved.
//

import UIKit

protocol CameraFunctionViewDelegate: NSObjectProtocol {
    
    func functionButtonClickAction(button: UIButton)
    
    func recordButtonClickAction(button: UIButton)
    
    func buttonLongPressAction()
    
    func filterSelectedIndex(index: Int)
    
    func countdownButtonClickAction(button: UIButton)
}

class CameraFunctionView: UIView, FilterSelectionViewDelegate {
    
    @IBOutlet var filterBottomView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var fullScreenRecordButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var beautyButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var timeTipLabel: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var stackViewTop: NSLayoutConstraint!
    
    //倒數專用
    @IBOutlet weak var countdownView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var countdownButton: UIButton!
    
    var topSaveAreaH: CGFloat = 0.0
    var bottomSaveArea: CGFloat = 0.0
    
    var delegate: CameraFunctionViewDelegate?

    //MARK: 自定義 init
    init(frame: CGRect, bottomSaveAreaHeight: CGFloat) {
        super.init(frame: frame)
        bottomSaveArea = bottomSaveAreaHeight
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    func loadXib() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CameraFunctionView", bundle: bundle)
        //透過nib來取得xibView
        let xibView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        xibView.frame = self.frame
        addSubview(xibView)
        //設定xibView的Constraint
        
        if #available(iOS 11.0, *) {
            topSaveAreaH = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        }
        
        if kScreenH >= 812 {
            stackViewTop.constant = 0
        } else {
            
        }
        
        addLongPressGesture()
        
        showFilterSelectionView()
        
        initViewModel()
        
        timeButton.alpha = 0
        //print("timeButton.isSelected = \(timeButton.isSelected)")
    }
    
    //長按錄影
    func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPress.minimumPressDuration = 1.0
        let fullScreenLongPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        fullScreenLongPress.minimumPressDuration = 1.0
        recordButton.addGestureRecognizer(longPress)
        fullScreenRecordButton.addGestureRecognizer(fullScreenLongPress)
    }

    //MARK: 長按錄影事件
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            if delegate != nil {
                if filterButton.isSelected {
                    filterButton.isSelected = false
                    filterBottomView.slideY(y: kScreenHeight, duration: 0.3)
                }
                delegate?.buttonLongPressAction()
            }
        }
    }
    
    //相機功能
    @IBAction func functionButtonAction(_ sender: UIButton) {
        
        if delegate != nil {
            delegate?.functionButtonClickAction(button: sender)
        }
        
        switch sender.tag {
        case 1://濾鏡
            FilterCameraViewModel.shared.openCustomFilterView()
//            if filterButton.isSelected {
//                filterButton.isSelected = false
//                filterBottomView.slideY(y: kScreenHeight, duration: 0.3)
//            } else {
//                filterButton.isSelected = true
//                filterBottomView.slideY(y: kScreenHeight-202-bottomSaveArea, duration: 0.3)
//            }
            break
        case 2://美肌
            beautyButton.isSelected = beautyButton.isSelected ? false : true
            break
        case 3://倒數計時
            timeButton.isSelected = timeButton.isSelected ? false : true
            timeTipLabel.isHidden = timeButton.isSelected ? false : true
            break
        case 4://切換鏡頭
            switchButton.isSelected = switchButton.isSelected ? false : true
            break
        case 5://閃光燈
            flashButton.isSelected = flashButton.isSelected ? false : true
            break
        default:
            break
        }
    }
    
    //MARK: 拍照功能
    @IBAction func recordButtonAction(_ sender: UIButton) {
        if recordButton.tag == 0 {
            recordButton.tag = 1
            if delegate != nil {
                if filterButton.isSelected {
                    filterButton.isSelected = false
                    filterBottomView.slideY(y: kScreenHeight, duration: 0.3)
                }
                delegate?.recordButtonClickAction(button: sender)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                self.recordButton.tag = 0
            }
        }
    }
    
    //濾鏡列表
    func showFilterSelectionView() {
        let filterSelectionView = FilterSelectionView(frame: CGRect(x: 0, y: 16, width: kScreenWidth, height: filterScrollViewHeight))
        filterSelectionView.delegate = self
        filterBottomView.addSubview(filterSelectionView)
    }

    func selectIndex(index: Int) {
        
        if delegate != nil {
            delegate?.filterSelectedIndex(index: index)
        }
    }
    
    func initViewModel() {
        
        //後鏡頭隱藏閃光燈
        FilterCameraViewModel.shared.isFlashButtonHidden = { [weak self] (hidden)  in
            self?.flashButton.isHidden = hidden
        }
        
        //顯示倒數提示
        FilterCameraViewModel.shared.hasToCountdown = { [weak self] (hidden)  in
            self?.countdownView.isHidden = hidden
        }
        
        //開始倒數
        FilterCameraViewModel.shared.countdownSetPresent = { [weak self] (number)  in
            if number == 0 {
                self?.countdownLabel.text = ""
            } else {
                self?.countdownLabel.text = number.description
            }
        }
    }
    
    //停止倒數按鈕事件
    @IBAction func countdownButtonAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.countdownButtonClickAction(button: sender)
        }
    }
}
