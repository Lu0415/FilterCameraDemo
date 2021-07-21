//
//  UIViewControllerExtension.swift
//  CGECameraDemo
//
//  Created by 盧彥辰 on 2021/7/19.
//

import Foundation
import AVFoundation
import Photos
import UIKit

extension UIViewController {
    
    //MARK: 未開啟相機或麥克風權限提視窗
    func toOutsideSettingOpenCameraAndMic() {
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "",
                                        message: "為了拍攝照片或錄製含有音效的影片需要開啟SMchat的相機及麥克風權限\r\n前往外部設定頁面檢查",
                                        preferredStyle: .alert)
            
            let okAction = UIAlertAction(title:"確認", style: .default, handler: {
                (action) -> Void in
                FilterCameraViewModel.shared.authorityAlertViewButtonEvent = true
            })
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
}
