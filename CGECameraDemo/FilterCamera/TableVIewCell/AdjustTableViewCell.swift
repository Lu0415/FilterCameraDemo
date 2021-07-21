//
//  AdjustTableViewCell.swift
//  CGECameraDemo
//
//  Created by 盧彥辰 on 2021/7/19.
//

import UIKit

class AdjustTableViewCell: UITableViewCell {

    @IBOutlet weak var valueNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    let fcvm = FilterCameraViewModel.shared
    let adjustItem: AdjustItem = AdjustItem()
    
    var tempType: AdjustTitle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchData(type: AdjustTitle) {
        
        tempType = type
        valueNameLabel.text = ""
        switch type {
        case .brightness:
            // brightness (亮度)
            settingSliderValue(fcvm.adjustData?.brightness.brightness ?? 0,
                               fcvm.adjustData?.brightness.brightnessMinRange ?? 0,
                               fcvm.adjustData?.brightness.brightnessMaxRange ?? 0)
            break
        case .contrast:
            // contrast (對比度)
            settingSliderValue(fcvm.adjustData?.contrast.contrast ?? 0,
                               fcvm.adjustData?.contrast.contrastMinRange ?? 0,
                               fcvm.adjustData?.contrast.contrastMaxRange ?? 0)
            break
        case .saturation:
            // saturation (飽和度)
            settingSliderValue(fcvm.adjustData?.saturation.saturation ?? 0,
                               fcvm.adjustData?.saturation.saturationMinRange ?? 0,
                               fcvm.adjustData?.saturation.saturationMaxRange ?? 0)
            break
        case .monochromeRed:
            // monochrome (黑白) Red
            valueNameLabel.text = "red: "
            settingMonochromeRedSliderValue()
            break
        case .monochromeGreen:
            // monochrome (黑白) Green
            valueNameLabel.text = "green: "
            settingMonochromeGreenSliderValue()
            break
        case .monochromeBlue:
            // monochrome (黑白) Blue
            valueNameLabel.text = "blue: "
            settingMonochromeBlueSliderValue()
            break
        case .monochromeCyan:
            // monochrome (黑白) Cyan
            valueNameLabel.text = "cyan: "
            settingMonochromeCyanSliderValue()

            break
        case .monochromeMagenta:
            // monochrome (黑白) Magenta
            valueNameLabel.text = "magenta: "
            settingMonochromeMagentaSliderValue()
            break
        case .monochromeYellow:
            // monochrome (黑白) Yellow
            valueNameLabel.text = "yellow: "
            settingMonochromeYellowSliderValue()
            break
        case .sharpen:
            // sharpen (銳化)
            settingSliderValue(fcvm.adjustData?.sharpen.sharpen ?? 0,
                               fcvm.adjustData?.sharpen.sharpenMinRange ?? 0,
                               fcvm.adjustData?.sharpen.sharpenMaxRange ?? 0)
            break
        case .blur:
            // blur (模糊)
            settingSliderValue(fcvm.adjustData?.blur.blur ?? 0,
                               fcvm.adjustData?.blur.blurMinRange ?? 0,
                               fcvm.adjustData?.blur.blurMaxRange ?? 0)
            break
        case .temperature:
            // whitebalance (白平衡) temperature
            valueNameLabel.text = "temperature: "
            settingSliderValue(fcvm.adjustData?.whitebalance.temperature ?? 0,
                               fcvm.adjustData?.whitebalance.temperatureMinRange ?? 0,
                               fcvm.adjustData?.whitebalance.temperatureMaxRange ?? 0)
            break
        case .tint:
            // whitebalance (白平衡) tint
            valueNameLabel.text = "tint: "
            settingSliderValue(fcvm.adjustData?.whitebalance.tint ?? 0,
                               fcvm.adjustData?.whitebalance.tintMinRange ?? 0,
                               fcvm.adjustData?.whitebalance.tintMaxRange ?? 0)
            break
        case .shadow:
            // shadowhighlight[shl] (陰影&高光) shadow
            valueNameLabel.text = "shadow: "
            settingSliderValue(fcvm.adjustData?.shadowhighlight.shadow ?? 0,
                               fcvm.adjustData?.shadowhighlight.shadowMinRange ?? 0,
                               fcvm.adjustData?.shadowhighlight.shadowMaxRange ?? 0)
            break
        case .highlight:
            // shadowhighlight[shl] (陰影&高光) highlight
            valueNameLabel.text = "highlight: "
            settingSliderValue(fcvm.adjustData?.shadowhighlight.highlight ?? 0,
                               fcvm.adjustData?.shadowhighlight.highlightMinRange ?? 0,
                               fcvm.adjustData?.shadowhighlight.highlightMaxRange ?? 0)
            break
            
        case .hsvRed:
            // hsv red
            valueNameLabel.text = "red: "
            settingSliderValue(fcvm.adjustData?.hsv.red ?? 0,
                               fcvm.adjustData?.hsv.hsvMinRange ?? 0,
                               fcvm.adjustData?.hsv.hsvMaxRange ?? 0)
            break
        case .hsvGreen:
            // hsv green
            valueNameLabel.text = "green: "
            settingSliderValue(fcvm.adjustData?.hsv.green ?? 0,
                               fcvm.adjustData?.hsv.hsvMinRange ?? 0,
                               fcvm.adjustData?.hsv.hsvMaxRange ?? 0)
            break
        case .hsvBlue:
            // hsv blue
            valueNameLabel.text = "blue: "
            settingSliderValue(fcvm.adjustData?.hsv.blue ?? 0,
                               fcvm.adjustData?.hsv.hsvMinRange ?? 0,
                               fcvm.adjustData?.hsv.hsvMaxRange ?? 0)
            break
        case .hsvCyan:
            // hsv cyan
            valueNameLabel.text = "cyan: "
            settingSliderValue(fcvm.adjustData?.hsv.cyan ?? 0,
                               fcvm.adjustData?.hsv.hsvMinRange ?? 0,
                               fcvm.adjustData?.hsv.hsvMaxRange ?? 0)
            break
        case .hsvMagenta:
            // hsv magenta
            valueNameLabel.text = "magenta: "
            settingSliderValue(fcvm.adjustData?.hsv.magenta ?? 0,
                               fcvm.adjustData?.hsv.hsvMinRange ?? 0,
                               fcvm.adjustData?.hsv.hsvMaxRange ?? 0)
            break
        case .hsvYellow:
            // hsv yellow
            valueNameLabel.text = "yellow: "
            settingSliderValue(fcvm.adjustData?.hsv.yellow ?? 0,
                               fcvm.adjustData?.hsv.hsvMinRange ?? 0,
                               fcvm.adjustData?.hsv.hsvMaxRange ?? 0)
            break
            
        case .hslHue:
            // hsl hue
            valueNameLabel.text = "hue: "
            settingSliderValue(fcvm.adjustData?.hsl.hue ?? 0,
                               fcvm.adjustData?.hsl.hslMinRange ?? 0,
                               fcvm.adjustData?.hsl.hslMaxRange ?? 0)
            break
        case .hslSaturation:
            // hsl saturation
            valueNameLabel.text = "saturation: "
            settingSliderValue(fcvm.adjustData?.hsl.saturation ?? 0,
                               fcvm.adjustData?.hsl.hslMinRange ?? 0,
                               fcvm.adjustData?.hsl.hslMaxRange ?? 0)
            break
        case .hslLuminance:
            // hsl luminance
            valueNameLabel.text = "luminance: "
            settingSliderValue(fcvm.adjustData?.hsl.luminance ?? 0,
                               fcvm.adjustData?.hsl.hslMinRange ?? 0,
                               fcvm.adjustData?.hsl.hslMaxRange ?? 0)
            break
            
        case .dark:
            // level (色階) dark
            valueNameLabel.text = "dark: "
            settingSliderValue(fcvm.adjustData?.level.dark ?? 0,
                               fcvm.adjustData?.level.levelMinRange ?? 0,
                               fcvm.adjustData?.level.levelMaxRange ?? 0)
            fcvm.resetLevelDarkSlider = { [self] () in
                settingSliderValue(fcvm.adjustData?.level.dark ?? 0,
                                   fcvm.adjustData?.level.levelMinRange ?? 0,
                                   fcvm.adjustData?.level.levelMaxRange ?? 0)
            }
            break
        case .light:
            // level (色階) light
            valueNameLabel.text = "light: "
            settingSliderValue(fcvm.adjustData?.level.light ?? 0,
                               fcvm.adjustData?.level.levelMinRange ?? 0,
                               fcvm.adjustData?.level.levelMaxRange ?? 0)
            
            fcvm.resetLevelLightSlider = { [self] () in
                settingSliderValue(fcvm.adjustData?.level.light ?? 0,
                                   fcvm.adjustData?.level.levelMinRange ?? 0,
                                   fcvm.adjustData?.level.levelMaxRange ?? 0)
            }
            break
        case .gamma:
            // level (色階) gamma
            valueNameLabel.text = "gamma: "
            settingSliderValue(fcvm.adjustData?.level.gamma ?? 0,
                               fcvm.adjustData?.level.levelMinRange ?? 0,
                               fcvm.adjustData?.level.levelMaxRange ?? 0)
            break
            
        case .intensity:
            // exposure (曝光) intensity
            settingSliderValue(fcvm.adjustData?.exposure.intensity ?? 0,
                               fcvm.adjustData?.exposure.exposureMinRange ?? 0,
                               fcvm.adjustData?.exposure.exposureMaxRange ?? 0)
            break
            
        case .redShift:
            // colorbalance (色彩平衡) redShift
            valueNameLabel.text = "redShift: "
            settingSliderValue(fcvm.adjustData?.colorbalance.redShift ?? 0,
                               fcvm.adjustData?.colorbalance.colorbalanceMinRange ?? 0,
                               fcvm.adjustData?.colorbalance.colorbalanceMaxRange ?? 0)
            break
        case .greenShift:
            // colorbalance (色彩平衡) greenShift
            valueNameLabel.text = "greenShift: "
            settingSliderValue(fcvm.adjustData?.colorbalance.greenShift ?? 0,
                               fcvm.adjustData?.colorbalance.colorbalanceMinRange ?? 0,
                               fcvm.adjustData?.colorbalance.colorbalanceMaxRange ?? 0)
            break
        case .blueShift:
            // colorbalance (色彩平衡) blueShift
            valueNameLabel.text = "blueShift: "
            settingSliderValue(fcvm.adjustData?.colorbalance.blueShift ?? 0,
                               fcvm.adjustData?.colorbalance.colorbalanceMinRange ?? 0,
                               fcvm.adjustData?.colorbalance.colorbalanceMaxRange ?? 0)
            break
            
        default:
            break
        }
    }
    
    func settingSliderValue(_ value: Float, _ min: Float, _ max: Float) {
        slider.minimumValue = min
        slider.maximumValue = max
        slider.value = value
        valueLabel.text = slider.value.description
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        
        //let _double: Double = Double(sender.value).ceiling(toDecimal: 3)
        let value = Float(Double(sender.value).ceiling(toDecimal: 3))
        
        valueLabel.text = value.description
        
        switch tempType {
        case .brightness:
            // brightness (亮度)
            fcvm.adjustData?.brightness.brightness = value
            singleValueChange(value)
            break
        case .contrast:
            // contrast (對比度)
            fcvm.adjustData?.contrast.contrast = value
            singleValueChange(value)
            break
        case .saturation:
            // saturation (飽和度)
            fcvm.adjustData?.saturation.saturation = value
            singleValueChange(value)
            break
        case .monochromeRed:
            // monochrome (黑白) Red
            fcvm.adjustData?.monochrome.red = value
            changeMonochromeValue()
            break
        case .monochromeGreen:
            // monochrome (黑白) Green
            fcvm.adjustData?.monochrome.green = value
            changeMonochromeValue()
            break
        case .monochromeBlue:
            // monochrome (黑白) Blue
            fcvm.adjustData?.monochrome.blue = value
            changeMonochromeValue()
            break
        case .monochromeCyan:
            // monochrome (黑白) Cyan
            fcvm.adjustData?.monochrome.cyan = value
            changeMonochromeValue()
            break
        case .monochromeMagenta:
            // monochrome (黑白) Magenta
            fcvm.adjustData?.monochrome.magenta = value
            changeMonochromeValue()
            break
        case .monochromeYellow:
            // monochrome (黑白) Yellow
            fcvm.adjustData?.monochrome.yellow = value
            changeMonochromeValue()
            break
        case .sharpen:
            // sharpen (銳化)
            fcvm.adjustData?.sharpen.sharpen = value
            singleValueChange(value)
            break
        case .blur:
            // blur (模糊)
            fcvm.adjustData?.blur.blur = value
            singleValueChange(value)
            break
        case .temperature:
            // whitebalance (白平衡) temperature
            fcvm.adjustData?.whitebalance.temperature = value
            changeWhitebalanceValue()
            break
        case .tint:
            // whitebalance (白平衡) tint
            fcvm.adjustData?.whitebalance.tint = value
            changeWhitebalanceValue()
            break
        case .shadow:
            // shadowhighlight[shl] (陰影&高光) shadow
            fcvm.adjustData?.shadowhighlight.shadow = value
            changeShadowhighlightValue()
            break
        case .highlight:
            // shadowhighlight[shl] (陰影&高光) highlight
            fcvm.adjustData?.shadowhighlight.highlight = value
            changeShadowhighlightValue()
            break
            
        case .hsvRed:
            // hsv Red
            fcvm.adjustData?.hsv.red = value
            changeHsvValue()
            break
        case .hsvGreen:
            // hsv Green
            fcvm.adjustData?.hsv.green = value
            changeHsvValue()
            break
        case .hsvBlue:
            // hsv Blue
            fcvm.adjustData?.hsv.blue = value
            changeHsvValue()
            break
        case .hsvCyan:
            // hsv Cyan
            fcvm.adjustData?.hsv.cyan = value
            changeHsvValue()
            break
        case .hsvMagenta:
            // hsv Magenta
            fcvm.adjustData?.hsv.magenta = value
            changeHsvValue()
            break
        case .hsvYellow:
            // hsv Yellow
            fcvm.adjustData?.hsv.yellow = value
            changeHsvValue()
            break
            
        case .hslHue:
            // hsl hue
            fcvm.adjustData?.hsl.hue = value
            changeHslValue()
            break
        case .hslSaturation:
            // hsl saturation
            fcvm.adjustData?.hsl.saturation = value
            changeHslValue()
            break
        case .hslLuminance:
            // hsl luminance
            fcvm.adjustData?.hsl.luminance = value
            changeHslValue()
            break
            
        case .dark:
            // level (色階) dark 其中 dark =< light
            fcvm.adjustData?.level.dark = value
            changeLevelValue()
            if value >= (fcvm.adjustData?.level.light)! {
                fcvm.adjustData?.level.light = value
                fcvm.changeLevelLightSlider()
            }
            break
        case .light:
            // level (色階) light 其中 dark =< light
            fcvm.adjustData?.level.light = value
            changeLevelValue()
            if value <= (fcvm.adjustData?.level.dark)! {
                fcvm.adjustData?.level.dark = value
                fcvm.changeLevelDarkSlider()
            }
            break
        case .gamma:
            // level (色階) gamma
            fcvm.adjustData?.level.gamma = value
            changeLevelValue()
            break
            
        case .intensity:
            // exposure (曝光) intensity
            fcvm.adjustData?.exposure.intensity = value
            singleValueChange(value)
            break
            
        case .redShift:
            // colorbalance (色彩平衡) redShift
            fcvm.adjustData?.colorbalance.redShift = value
            changeColorbalanceValue()
            break
        case .greenShift:
            // colorbalance (色彩平衡) greenShift
            fcvm.adjustData?.colorbalance.greenShift = value
            changeColorbalanceValue()
            break
        case .blueShift:
            // colorbalance (色彩平衡) blueShift
            fcvm.adjustData?.colorbalance.blueShift = value
            changeColorbalanceValue()
            break
            
        default:
            break
        }
    }
    
    // 單一參數
    func singleValueChange(_ value: Float) {
        
        var name = ""
        if tempType!.rawValue == "intensity" {
            name = "exposure "
        } else {
            name = tempType!.rawValue + " "
        }
        
        adjustItem.itemName = name
        adjustItem.itemValue = value.description + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
    
    // monochrome (黑白) 組合參數
    func changeMonochromeValue() {
        adjustItem.itemName = "monochrome" + " "
        
        let redStr: String = (fcvm.adjustData?.monochrome.red.description)!
        let greenStr: String = (fcvm.adjustData?.monochrome.green.description)!
        let blueStr: String = (fcvm.adjustData?.monochrome.blue.description)!
        let cyanStr: String = (fcvm.adjustData?.monochrome.cyan.description)!
        let magentaStr: String = (fcvm.adjustData?.monochrome.magenta.description)!
        let yellowStr: String = (fcvm.adjustData?.monochrome.yellow.description)!
        
        let valueStr: String = redStr + " " + greenStr + " " + blueStr + " " +
            cyanStr + " " + magentaStr + " " + yellowStr + " "
        
        adjustItem.itemValue = valueStr + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
    
    // whitebalance (白平衡) 組合參數
    func changeWhitebalanceValue() {
        adjustItem.itemName = "whitebalance" + " "
        
        let temperatureStr: String = (fcvm.adjustData?.whitebalance.temperature.description)!
        let tintStr: String = (fcvm.adjustData?.whitebalance.tint.description)!
        
        let valueStr: String = temperatureStr + " " + tintStr + " "
        
        adjustItem.itemValue = valueStr + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
    
    // shadowhighlight[shl] (陰影&高光) 組合參數
    func changeShadowhighlightValue() {
        adjustItem.itemName = "shadowhighlight" + " "
        
        let temperatureStr: String = (fcvm.adjustData?.shadowhighlight.shadow.description)!
        let tintStr: String = (fcvm.adjustData?.shadowhighlight.highlight.description)!
        
        let valueStr: String = temperatureStr + " " + tintStr + " "
        
        adjustItem.itemValue = valueStr + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
    
    // hsv 組合參數
    func changeHsvValue() {
        adjustItem.itemName = "hsv" + " "
        
        let redStr: String = (fcvm.adjustData?.hsv.red.description)!
        let greenStr: String = (fcvm.adjustData?.hsv.green.description)!
        let blueStr: String = (fcvm.adjustData?.hsv.blue.description)!
        let cyanStr: String = (fcvm.adjustData?.hsv.cyan.description)!
        let magentaStr: String = (fcvm.adjustData?.hsv.magenta.description)!
        let yellowStr: String = (fcvm.adjustData?.hsv.yellow.description)!
        
        let valueStr: String = redStr + " " + greenStr + " " + blueStr + " " +
            cyanStr + " " + magentaStr + " " + yellowStr + " "
        
        adjustItem.itemValue = valueStr + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
    
    // hsl 組合參數
    func changeHslValue() {
        adjustItem.itemName = "hsl" + " "
        
        let hueStr: String = (fcvm.adjustData?.hsl.hue.description)!
        let saturationStr: String = (fcvm.adjustData?.hsl.saturation.description)!
        let luminanceStr: String = (fcvm.adjustData?.hsl.luminance.description)!
        
        let valueStr: String = hueStr + " " + saturationStr + " " + luminanceStr + " "
        
        adjustItem.itemValue = valueStr + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
    
    // level (色階) 組合參數
    func changeLevelValue() {
        adjustItem.itemName = "level" + " "
        
        let darkStr: String = (fcvm.adjustData?.level.dark.description)!
        let lightStr: String = (fcvm.adjustData?.level.light.description)!
        let gammaStr: String = (fcvm.adjustData?.level.gamma.description)!
        
        let valueStr: String = darkStr + " " + lightStr + " " + gammaStr + " "
        
        adjustItem.itemValue = valueStr + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
    
    // colorbalance (色彩平衡) 組合參數
    func changeColorbalanceValue() {
        adjustItem.itemName = "colorbalance" + " "
        
        let redShift: String = (fcvm.adjustData?.colorbalance.redShift.description)!
        let greenShift: String = (fcvm.adjustData?.colorbalance.greenShift.description)!
        let blueShift: String = (fcvm.adjustData?.colorbalance.blueShift.description)!
        
        let valueStr: String = redShift + " " + greenShift + " " + blueShift + " "
        
        adjustItem.itemValue = valueStr + " "
        fcvm.setAdjustItem(item: adjustItem)
    }
}

extension AdjustTableViewCell {
    
    func settingMonochromeRedSliderValue() {
        settingSliderValue(fcvm.adjustData?.monochrome.red ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMinRange ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMaxRange ?? 0)
    }
    
    func settingMonochromeGreenSliderValue() {
        settingSliderValue(fcvm.adjustData?.monochrome.green ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMinRange ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMaxRange ?? 0)
    }
    
    func settingMonochromeBlueSliderValue() {
        settingSliderValue(fcvm.adjustData?.monochrome.blue ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMinRange ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMaxRange ?? 0)
    }
    
    func settingMonochromeCyanSliderValue() {
        settingSliderValue(fcvm.adjustData?.monochrome.cyan ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMinRange ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMaxRange ?? 0)
    }
    
    func settingMonochromeMagentaSliderValue() {
        settingSliderValue(fcvm.adjustData?.monochrome.magenta ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMinRange ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMaxRange ?? 0)
    }
    
    func settingMonochromeYellowSliderValue() {
        settingSliderValue(fcvm.adjustData?.monochrome.yellow ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMinRange ?? 0,
                           fcvm.adjustData?.monochrome.monochromeMaxRange ?? 0)
    }
    
}

extension Double {
    func ceiling(toDecimal decimal: Int) -> Double {
        let numberOfDigits = abs(pow(10.0, Double(decimal)))
        if self.sign == .minus {
            return Double(Int(self * numberOfDigits)) / numberOfDigits
        } else {
            return Double(ceil(self * numberOfDigits)) / numberOfDigits
        }
    }
}
