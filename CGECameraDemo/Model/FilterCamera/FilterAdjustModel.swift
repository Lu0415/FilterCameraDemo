//
//  FilterAdjustModel.swift
//  CGECameraDemo
//
//  Created by 盧彥辰 on 2021/7/19.
//

import Foundation
import BaseJson4

class AdjustItem: BaseJson4 {
    var item: String = "@adjust "
    var itemName: String = ""
    var itemValue: String = ""
}

class Adjust: BaseJson4 {
    
    var brightness: AdjustBrightness = AdjustBrightness()
    var contrast: AdjustContrast = AdjustContrast()
    var saturation: AdjustSaturation = AdjustSaturation()
    var monochrome: AdjustMonochrome = AdjustMonochrome()
    var sharpen: AdjustSharpen = AdjustSharpen()
    var blur: AdjustBlur = AdjustBlur()
    var whitebalance: AdjustWhitebalance = AdjustWhitebalance()
    var shadowhighlight: AdjustShadowhighlight = AdjustShadowhighlight()
    var hsv: AdjustHsv = AdjustHsv()
    var hsl: AdjustHsl = AdjustHsl()
    var level: AdjustLevel = AdjustLevel()
    var exposure: AdjustExposure = AdjustExposure()
    var colorbalance: AdjustColorbalance = AdjustColorbalance()
}

// brightness (亮度): 後接一個參數 intensity, 范圍 [-1, 1]
class AdjustBrightness: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "brightness (亮度)"
    
    var brightnessMinRange: Float = -1
    var brightnessMaxRange: Float = 1
    
    var brightness: Float = 0
}

// contrast (對比度): 後接一個參數 intensity, 范圍 intensity > 0, 當 intensity = 0 時為灰色圖像, intensity = 1 時為無效果, intensity > 1 時加強對比度
class AdjustContrast: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "contrast (對比度)"
    
    var contrastMinRange: Float = 0
    var contrastMaxRange: Float = 10
    
    var contrast: Float = 1
}

// saturation (飽和度): 後接一個參數 intensity, 范圍 intensity > 0, 當 intensity = 0 時為黑白圖像, intensity = 1 時為無效果， intensity > 1 時加強飽和度
class AdjustSaturation: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "saturation (飽和度)"
    
    var saturationMinRange: Float = 0
    var saturationMaxRange: Float = 10
    
    var saturation: Float = 1
}

// monochrome (黑白): 後接六個參數, 范圍 [-2, 3], 與photoshop一致。參數順序分別為: red, green, blue, cyan, magenta, yellow
class AdjustMonochrome: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "monochrome (黑白)"
    
    var monochromeMinRange: Float = -2
    var monochromeMaxRange: Float = 3
    
    var red: Float = 0
    var green: Float = 0
    var blue: Float = 0
    var cyan: Float = 0
    var magenta: Float = 0
    var yellow: Float = 0
}

// sharpen (銳化): 後接一個參數 intensity, 范圍 [0, 10], 當intensity為0時無效果
class AdjustSharpen: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "sharpen (銳化)"
    
    var sharpenMinRange: Float = 0
    var sharpenMaxRange: Float = 10
    
    var sharpen: Float = 0
}

// blur (模糊): 後接一個參數 intensity, 范圍 [0, 1], 當 intensity 為0時無效果
class AdjustBlur: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "blur (模糊)"
    
    var blurMinRange: Float = 0
    var blurMaxRange: Float = 1
    
    var blur: Float = 0
}

// whitebalance (白平衡): 後接兩個參數 temperature (范圍：[-1, 1], 0為無效果) 和 tint (范圍: [0, 5], 1 為無效果)
class AdjustWhitebalance: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "whitebalance (白平衡)"
    
    var temperatureMinRange: Float = -1
    var temperatureMaxRange: Float = 1
    
    var temperature: Float = 0
    
    var tintMinRange: Float = 0
    var tintMaxRange: Float = 5
    
    var tint: Float = 1
}

// shadowhighlight[shl] (陰影&高光): 後接兩個參數 shadow(范圍: [-200, 100], 0為無效果) 和 highlight(范圍: [-100, 200], 0為無效果)
class AdjustShadowhighlight : BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "shadowhighlight[shl] (陰影&高光)"
    
    var shadowMinRange: Float = -200
    var shadowMaxRange: Float = 100
    
    var shadow: Float = 0
    
    var highlightMinRange: Float = -100
    var highlightMaxRange: Float = 200
    
    var highlight: Float = 0
}

// hsv: 後接六個參數red, green, blue, magenta, yellow, cyan. 六個參數范圍均為 [-1, 1]
class AdjustHsv: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "hsv"
    
    var hsvMinRange: Float = -1
    var hsvMaxRange: Float = 1
    
    var red: Float = 0
    var green: Float = 0
    var blue: Float = 0
    var magenta: Float = 0
    var yellow: Float = 0
    var cyan: Float = 0
}

// hsl: 後接三個參數hue, saturation, luminance， 三個參數范圍均為 [-1, 1]
class AdjustHsl: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "hsl"
    
    var hslMinRange: Float = -1
    var hslMaxRange: Float = 1
    
    var hue: Float = 0
    var saturation: Float = 0
    var luminance: Float = 0
}

// level (色階): 後接三個參數 dark, light, gamma, 范圍均為[0, 1], 其中 dark =< light
class AdjustLevel: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "level (色階)"
    
    var levelMinRange: Float = 0
    var levelMaxRange: Float = 1
    var darkSmaller: Bool = true
    
    var dark: Float = 0
    var light: Float = 0
    var gamma: Float = 0
}

// exposure (曝光): 後接一個參數 intensity, 范圍 [-10, 10]
class AdjustExposure: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "exposure (曝光)"
    
    var exposureMinRange: Float = -10
    var exposureMaxRange: Float = 10
    
    var intensity: Float = 0
}

// colorbalance (色彩平衡): 後接三個參數 redShift [-1, 1], greenShift [-1, 1], blueShift [-1, 1]
class AdjustColorbalance: BaseJson4 {
    
    var isChanged: Bool = false
    var optionTitle: String = "colorbalance (色彩平衡)"
    
    var colorbalanceMinRange: Float = -1
    var colorbalanceMaxRange: Float = 1
    
    var redShift: Float = 0
    var greenShift: Float = 0
    var blueShift: Float = 0
}

//adjust
public enum AdjustTitle: String, CaseIterable {

    // brightness (亮度)
    case adjustBrightness = "adjustBrightness"
    case brightness = "brightness"

    // contrast (對比度)
    case adjustContrast = "adjustContrast"
    case contrast = "contrast"

    // saturation (飽和度)
    case adjustSaturation = "adjustSaturation"
    case saturation = "saturation"

    // monochrome (黑白)
    case adjustMonochrome = "adjustMonochrome"
    case monochromeRed = "monochromeRed"
    case monochromeGreen = "monochromeGreen"
    case monochromeBlue = "monochromeBlue"
    case monochromeCyan = "monochromeCyan"
    case monochromeMagenta = "monochromeMagenta"
    case monochromeYellow = "monochromeYellow"

    // sharpen (銳化)
    case adjustSharpen = "adjustSharpen"
    case sharpen = "sharpen"

    // blur (模糊)
    case adjustBlur = "adjustBlur"
    case blur = "blur"

    // whitebalance (白平衡)
    case adjustWhitebalance = "adjustWhitebalance"
    case temperature = "temperature"
    case tint = "tint"

    // shadowhighlight[shl] (陰影&高光)
    case adjustShadowhighlight = "adjustShadowhighlight"
    case shadow = "shadow"
    case highlight = "highlight"

    // hsv
    case adjustHsv = "adjustHsv"
    case hsvRed = "hsvRed"
    case hsvGreen = "hsvGreen"
    case hsvBlue = "hsvBlue"
    case hsvCyan = "hsvCyan"
    case hsvMagenta = "hsvMagenta"
    case hsvYellow = "hsvYellow"

    // hsl
    case adjustHsl = "adjustHsl"
    case hslHue = "hslHue"
    case hslSaturation = "hslSaturation"
    case hslLuminance = "hslLuminance"

    // level (色階)
    case adjustLevel = "adjustLevel"
    case dark = "dark"
    case light = "light"
    case gamma = "gamma"

    // exposure (曝光)
    case adjustExposure = "adjustExposure"
    case intensity = "intensity"

    // colorbalance (色彩平衡)
    case adjustColorbalance = "adjustColorbalance"
    case redShift = "redShift"
    case greenShift = "greenShift"
    case blueShift = "blueShift"

}
