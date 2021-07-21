//
//  AdjustTitleTableViewCell.swift
//  CGECameraDemo
//
//  Created by 盧彥辰 on 2021/7/19.
//

import UIKit

class AdjustTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var tempTitle: AdjustTitle!
    let fcvm = FilterCameraViewModel.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchData(title: AdjustTitle) {
        
        tempTitle = title
        
        switch title {
        case .adjustBrightness:
            titleLabel.text = "brightness (亮度)"
            break
        case .adjustContrast:
            titleLabel.text = "contrast (對比度)"
            break
        case .adjustSaturation:
            titleLabel.text = "saturation (飽和度)"
            break
        case .adjustMonochrome:
            titleLabel.text = "monochrome (黑白)"
            break
        case .adjustSharpen:
            titleLabel.text = "sharpen (銳化)"
            break
        case .adjustBlur:
            titleLabel.text = "blur (模糊)"
            break
        case .adjustWhitebalance:
            titleLabel.text = "whitebalance (白平衡)"
            break
        case .adjustShadowhighlight:
            titleLabel.text = "shadowhighlight[shl] (陰影&高光)"
            break
        case .adjustHsv:
            titleLabel.text = "hsv"
            break
        case .adjustHsl:
            titleLabel.text = "hsl"
            break
        case .adjustLevel:
            titleLabel.text = "level (色階)"
            break
        case .adjustExposure:
            titleLabel.text = "exposure (曝光)"
            break
        case .adjustColorbalance:
            titleLabel.text = "colorbalance (色彩平衡)"
            break
        default:
            break
        }
    }
    
    // 單一項目重新設定按鈕事件
    @IBAction func resetButtonAction(_ sender: UIButton) {
        fcvm.resetAdjustSingleEffect(tempTitle)
    }
    
}
