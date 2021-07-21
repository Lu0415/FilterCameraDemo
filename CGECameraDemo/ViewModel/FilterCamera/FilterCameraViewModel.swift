//
//  FilterCameraViewModel.swift
//  ChatRoomPostData
//
//  Created by sameapple on 2020/2/5.
//  Copyright © 2020 sameapple. All rights reserved.
//

import Foundation

class FilterCameraViewModel: NSObject, CustomFilterViewDelegate {
    
    static let shared = FilterCameraViewModel()
    
    var fileSendToWho: String = ""
    var isFromChatRoom: Bool = false
    var isFromPicker: Bool = false
    var isPhoto: Bool = true
    
    var progressSetPresent = {(time: Float) -> () in }
    
    var isFlashButtonHidden = {(hidden: Bool) -> () in }
    
    var hasToCountdown = {(status: Bool) -> () in }
    
    var countdownSetPresent = {(status: Int) -> () in }
    
    var closeFileTooLargeTipView = {() -> () in }
    
    var closeAuthorityAlertView = {() -> () in }
    
    var progressTime: Float = 0.0 {
        didSet {
            progressSetPresent(progressTime)
        }
    }
    
    var flashButtonHidden: Bool = true {
        didSet {
            isFlashButtonHidden(flashButtonHidden)
        }
    }
    
    var countdownViewHidden: Bool = true {
        didSet {
            hasToCountdown(countdownViewHidden)
        }
    }
    
    var countdownNumber: Int = 3 {
        didSet {
            countdownSetPresent(countdownNumber)
        }
    }
    
    var fileTooLargeButtonEvent: Bool = false {
        didSet {
            closeFileTooLargeTipView()
        }
    }
    
//    //MARK: form data 資料整理
//    func photoUploadParams(authorization: String, photo: Data, cover: Data) -> ([String: Any]) {
//        var params: [String: Any] = [:]
//        if isFromChatRoom {
//            params = [
//                "authorization": authorization,
//                "token": aesToken(),
//                "isPhoto": true,
//                "photoFile": photo as Any,
//                "cover": cover as Any]
//        } else {
//            params = [
//                "authorization": authorization,
//                "token": aesToken(),
//                "isPhoto": true,
//                "photoFile": photo as Any,
//                "cover": cover as Any]
//        }
//        return params
//    }
    
//    func videoUploadParams(authorization: String, video: Data) -> ([String: Any]) {
//        var params: [String: Any] = [:]
//        if isFromChatRoom {
//            params = [
//                "authorization": authorization,
//                "token": aesToken(),
//                "isPhoto": false,
//                "videoFile": video as Any]
//        } else {
//            params = [
//                "authorization": authorization,
//                "token": aesToken(),
//                "isPhoto": false,
//                "videoFile": video as Any]
//        }
//        return params
//    }
    
//    func aesToken() -> String {
//        let token: [String: Any] = [
//            "smeethID": UserObject.getShid(),
//            "timestamp": gettimeStamp()
//        ]
//        let aesString: String = TransJson.jsonToAES(jsonDic: token)!
//        return aesString
//    }
    
//    //MARK: 是否開啟設定水鑽
//    func canSetDiamond(isPhoto: Bool) -> (Bool) {
//
//        if isFromChatRoom { //聊天室內上傳
//            if isFromPicker && isPhoto {
//                //直接上傳
//                return false
//            } else {
//                if UserObject.getSmeethGirlStatus() {
//                    //開啟設定水鑽
//                    return true
//                } else {
//                    //直接上傳
//                    return false
//                }
//            }
//        } else { //外面動態上傳
//            if isFromPicker {
//                //直接上傳
//                return false
//            } else {
//                //開啟設定水鑽
//                return true
//            }
//        }
//    }
    
    func returnUseDismiss(isPhoto: Bool) -> (Bool) {
        
        if isPhoto == false && isFromPicker {
            return true
        } else {
            if isFromChatRoom {
                return false
            } else {
                if isFromPicker {
                    return false
                } else {
                    return true
                }
            }
        }
    }
    
    //MARK: 相機及麥克風權限按鈕事件
    var authorityAlertViewButtonEvent: Bool = false {
        didSet {
            closeAuthorityAlertView()
        }
    }
    
    var postDynamicCloseFilterCamera = {(shouldClose: Bool) -> () in }
    var closeFilterCamera: Bool = false {
        didSet {
            postDynamicCloseFilterCamera(closeFilterCamera)
        }
    }
    
    var adjustArray: [AdjustTitle] = []
    var adjustData: Adjust?
    func getAdjustArray() {
        
        adjustData = Adjust()
        
        AdjustTitle.allCases.forEach {
            print($0.rawValue)
            adjustArray.append(AdjustTitle(rawValue: $0.rawValue)!)
        }
        
        //print("adjustArray = ", adjustArray)
    }
    
    var adjustItemArray: [AdjustItem] = []
    
    func clearAdjustItemArray() {
        adjustItemArray.removeAll()
    }
    
    var filterEffect: String = ""
    var changeFilterEffect = {(effectStr: String) -> () in }
    func setAdjustItem(item: AdjustItem) {
        if adjustItemArray.count == 0 {
            adjustItemArray.append(item)
        } else {
            for (i, _) in adjustItemArray.enumerated().reversed() {
                if item.itemName == adjustItemArray[i].itemName {
                    adjustItemArray.remove(at: i)
                }
            }
            adjustItemArray.append(item)
        }
        
        setFilterEffectConstString()
    }
    
    //
    func setFilterEffectConstString() {
        filterEffect = ""
        adjustItemArray.forEach { (obj) in
            let str = obj.item + obj.itemName + " " + obj.itemValue + " "
            filterEffect += str
        }
        
        changeFilterEffect(filterEffect)
    }
    
    func openCustomFilterView() {
        let window = UIWindow.key
        let customFilterView = CustomFilterView(frame: window!.bounds)
        customFilterView.tag = 12345678
        customFilterView.delegate = self
        window!.addSubview(customFilterView)
    }
    
    var resetLevelDarkSlider = {() -> () in }
    func changeLevelDarkSlider() {
        resetLevelDarkSlider()
    }
    
    var resetLevelLightSlider = {() -> () in }
    func changeLevelLightSlider() {
        resetLevelLightSlider()
    }
    
    // 單一項目重新設定
    var resetMonochromeSlider = {() -> () in }
    func resetAdjustSingleEffect(_ title: AdjustTitle) {
        switch title {
        case .adjustBrightness: // brightness (亮度)
            adjustData?.brightness.brightness = 0
            removeAdjustItem(name: "brightness ")
            resetMonochromeSlider()
            break
        case .adjustContrast: // contrast (對比度)
            adjustData?.contrast.contrast = 1
            removeAdjustItem(name: "contrast ")
            resetMonochromeSlider()
            break
        case .adjustSaturation: // saturation (飽和度)
            adjustData?.saturation.saturation = 1
            removeAdjustItem(name: "saturation ")
            resetMonochromeSlider()
            break
        case .adjustMonochrome: // monochrome (黑白)
            adjustData?.monochrome.red = 0
            adjustData?.monochrome.green = 0
            adjustData?.monochrome.blue = 0
            adjustData?.monochrome.cyan = 0
            adjustData?.monochrome.magenta = 0
            adjustData?.monochrome.yellow = 0
            removeAdjustItem(name: "monochrome ")
            resetMonochromeSlider()
            break
        case .adjustSharpen: // sharpen (銳化)
            adjustData?.sharpen.sharpen = 0
            removeAdjustItem(name: "sharpen ")
            resetMonochromeSlider()
            break
        case .adjustBlur: // blur (模糊)
            adjustData?.blur.blur = 0
            removeAdjustItem(name: "blur ")
            resetMonochromeSlider()
            break
        case .adjustWhitebalance: // whitebalance (白平衡)
            adjustData?.whitebalance.temperature = 0
            adjustData?.whitebalance.tint = 1
            removeAdjustItem(name: "whitebalance ")
            resetMonochromeSlider()
            break
        case .adjustShadowhighlight: // shadowhighlight[shl] (陰影&高光)
            adjustData?.shadowhighlight.shadow = 0
            adjustData?.shadowhighlight.highlight = 0
            removeAdjustItem(name: "shadowhighlight ")
            resetMonochromeSlider()
            break
        case .adjustHsv: // hsv
            adjustData?.hsv.red = 0
            adjustData?.hsv.green = 0
            adjustData?.hsv.blue = 0
            adjustData?.hsv.cyan = 0
            adjustData?.hsv.magenta = 0
            adjustData?.hsv.yellow = 0
            removeAdjustItem(name: "hsv ")
            resetMonochromeSlider()
            break
        case .adjustHsl: // hsl
            adjustData?.hsl.hue = 0
            adjustData?.hsl.saturation = 0
            adjustData?.hsl.luminance = 0
            removeAdjustItem(name: "hsl ")
            resetMonochromeSlider()
            break
        case .adjustLevel: // level (色階)
            adjustData?.level.dark = 0
            adjustData?.level.light = 0
            adjustData?.level.gamma = 0
            removeAdjustItem(name: "level ")
            resetMonochromeSlider()
            break
        case .adjustExposure: // exposure (曝光)
            adjustData?.exposure.intensity = 0
            removeAdjustItem(name: "exposure ")
            resetMonochromeSlider()
            break
        case .adjustColorbalance: // colorbalance (色彩平衡)
            adjustData?.colorbalance.redShift = 0
            adjustData?.colorbalance.greenShift = 0
            adjustData?.colorbalance.blueShift = 0
            removeAdjustItem(name: "colorbalance ")
            resetMonochromeSlider()
            break
        default:
            break
        }
    }
    
    //
    func removeAdjustItem(name: String) {
        print(("removeAdjustItem count = ", adjustItemArray.count))
        if adjustItemArray.count == 0 {
            return
        }
        print("removeAdjustItem name = ", name)
        for (i, _) in adjustItemArray.enumerated().reversed() {
            if name == adjustItemArray[i].itemName {
                adjustItemArray.remove(at: i)
            }
        }
        print("removeAdjustItem adjustItemArray = ", adjustItemArray)
        setFilterEffectConstString()
    }
    
    func customFilterCancelAction(_ button: UIButton) {
        closeCustomFilterView()
    }
    
    func customFilterConfirmAction(_ button: UIButton) {
        closeCustomFilterView()
    }
    
    func closeCustomFilterView() {
        closeWindowTipView(tag: 12345678)
    }
    
    func closeWindowTipView(tag: Int) {
        if let window = UIWindow.key {
            window.viewWithTag(tag)?.removeFromSuperview()
        }
    }
    
}

