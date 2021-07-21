//
//  FilterSelectionView.swift
//  ChatRoomPostData
//
//  Created by sameapple on 2020/2/5.
//  Copyright © 2020 sameapple. All rights reserved.
//

import UIKit

protocol FilterSelectionViewDelegate: NSObjectProtocol {
    
    func selectIndex(index: Int)
}

class FilterSelectionView: UIView {
    
    var delegate: FilterSelectionViewDelegate?
    
    var index: Int = 0
    var imageFrame: CGRect = CGRect(x: 0, y: 0, width: filterImageWidth, height: filterImageHeight)
    var buttonFrame: CGRect = CGRect(x: 0, y: 0, width: filterImageWidth, height: filterImageHeight)
    var labelFrame: CGRect = CGRect(x: 0, y: filterImageHeight, width: filterImageWidth, height: filterLabelHeight)
    
    var selectedIndex: Int = 0
    var filterImage: UIImageView!
    var filterButton: UIButton!
    var buttonSender: UIButton!
    var filterLabel: UILabel!
    
    lazy var filterScrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: filterScrollViewHeight))
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()

    //MARK: 自定義 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFilterData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setFilterData()
    }
    
    func setFilterData() {
        
        titleArray.forEach ({ (title) in
            
            filterImage = UIImageView(frame: imageFrame)
            filterImage.backgroundColor = UIColor.clear
            filterImage.tag = 100+index
            filterImage.image = UIImage(named: "colorfilter\(index)")
            filterScrollView.addSubview(filterImage)
            imageFrame.origin.x += buttonFrame.width+4
            
            filterButton = UIButton(frame: buttonFrame)
            filterButton.backgroundColor = UIColor.clear
            filterButton.addTarget(self, action: #selector(filterButtonAction(button:)), for: .touchUpInside)
            filterButton.tag = index
            filterScrollView.addSubview(filterButton)
            buttonFrame.origin.x += buttonFrame.width+4
            
            if index == 0 {
                buttonSender = filterButton
            }
            
            filterLabel = UILabel(frame: labelFrame)
            filterLabel.backgroundColor = UIColor.clear
            filterLabel.textColor = UIColor.white
            filterLabel.font = UIFont.systemFont(ofSize: 14)
            filterLabel.textAlignment = NSTextAlignment.center
            filterLabel.tag = 1000+index
            filterLabel.text = titleArray[index]
            filterScrollView.addSubview(filterLabel)
            labelFrame.origin.x += labelFrame.size.width+4
            
            index+=1
        })
        
        filterScrollView.contentSize = CGSize(width: buttonFrame.origin.x, height: filterScrollViewHeight)
        self.addSubview(filterScrollView)
        filterButtonAction(button: buttonSender)
    }
    
    @objc func filterButtonAction(button: UIButton) {
        
        let oldLabelSender: UILabel = filterScrollView.viewWithTag(1000+selectedIndex) as! UILabel
        oldLabelSender.font = UIFont.systemFont(ofSize: 14)
        
        selectedIndex = button.tag
        
        let labelSender: UILabel = filterScrollView.viewWithTag(1000+button.tag) as! UILabel
        labelSender.font = UIFont.boldSystemFont(ofSize: 14)
        
        if buttonSender == button {
            button.setImage(UIImage(named: "tick"), for: .normal)
            button.backgroundColor = c433127
        } else {
            //選擇現有按鈕
            button.setImage(UIImage(named: "tick"), for: .normal)
            button.backgroundColor = c433127
            //取得先前複製的按鈕
            if buttonSender != nil {
                let oldButtonSender = buttonSender
                //將先前複製的按鈕恢復預設值
                oldButtonSender!.setImage(UIImage(named: ""), for: .normal)
                oldButtonSender!.backgroundColor = UIColor.clear
            }
        }
        
        if delegate != nil {
            delegate?.selectIndex(index: button.tag)
        }
        
        buttonSender = button
    }

}

public extension Array {

    // Translate [String] to (const char * const *), which translates to Swift as
    func cStringArray() throws -> ArrayBridge<Element,CChar> {
        return try ArrayBridge<Element,CChar>(array:self) {
            guard let item = $0 as? String,
                  let translated = item.cString(using: .utf8) else {
                fatalError()
            }
            return translated
        }
    }
}

/*
 We need to have this intermediate object around to hold on to the translated objects, otherwise they will go away.
 The UnsafePointer won't hold on to the objects that it's pointing to.
 */
public struct ArrayBridge<SwiftType,CType> {

    let originals  :[SwiftType]
    let translated :[[CType]]
    let pointers   :[UnsafePointer<CType>?]
    public let pointer    :UnsafePointer<UnsafePointer<CType>?>

    init(array :[SwiftType], transform: @escaping (SwiftType) throws -> [CType]) throws {
        self.originals = array
        self.translated = try array.map(transform)

        var pointers = [UnsafePointer<CType>?]()
        for item in translated {
            pointers.append(UnsafePointer<CType>(item))
        }
        pointers.append(nil)
        self.pointers = pointers
        self.pointer = UnsafePointer(self.pointers)
    }
}
