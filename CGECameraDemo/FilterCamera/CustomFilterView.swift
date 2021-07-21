//
//  CustomFilterView.swift
//  CGECameraDemo
//
//  Created by 盧彥辰 on 2021/7/19.
//

import UIKit

protocol CustomFilterViewDelegate: NSObjectProtocol {
    
    func customFilterCancelAction(_ button: UIButton)
    
    func customFilterConfirmAction(_ button: UIButton)
}

class CustomFilterView: UIView {

    @IBOutlet weak var adjustTableView: UITableView!
    
    var delegate: CustomFilterViewDelegate?
    
    var titleCell: AdjustTitleTableViewCell!
    var optionCell: AdjustTableViewCell!
    
    let fcvm = FilterCameraViewModel.shared
    
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
        let nib = UINib(nibName: "CustomFilterView", bundle: bundle)
        //透過nib來取得xibView
        let xibView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        xibView.frame = self.frame
        addSubview(xibView)
        //設定xibView的Constraint
        registerTableViewCell()
        
        fcvm.resetMonochromeSlider = { [self] () in
            adjustTableView.reloadData()
        }
    }
    
    
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        delegate?.customFilterCancelAction(sender)
    }
    
    
    func registerTableViewCell() {
        adjustTableView.register(UINib(nibName: "AdjustTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "AdjustTitleTableViewCell")
        adjustTableView.register(UINib(nibName: "AdjustTableViewCell", bundle: nil), forCellReuseIdentifier: "AdjustTableViewCell")
    }
    
}

extension CustomFilterView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fcvm.adjustArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let title = fcvm.adjustArray[indexPath.row]
        
        print("fcvm.adjustArray[indexPath.row] = ", fcvm.adjustArray[indexPath.row])
        
        switch title {
        case .adjustBrightness, .adjustContrast, .adjustSaturation, .adjustMonochrome, .adjustSharpen, .adjustBlur,
             .adjustWhitebalance, .adjustShadowhighlight, .adjustHsv, .adjustHsl, .adjustLevel, .adjustExposure,
             .adjustColorbalance:
            titleCell = tableView.dequeueReusableCell(withIdentifier: "AdjustTitleTableViewCell", for: indexPath) as? AdjustTitleTableViewCell
            titleCell.fetchData(title: title)
            return titleCell
        default:
            optionCell = tableView.dequeueReusableCell(withIdentifier: "AdjustTableViewCell", for: indexPath) as? AdjustTableViewCell
            optionCell.fetchData(type: title)
            return optionCell
        }
    }
    
    
    
}
