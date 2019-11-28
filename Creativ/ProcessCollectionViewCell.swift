//
//  ProcessCollectionViewCell.swift
//  Creativ
//
//  Created by Owen Prasetya on 11/11/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit
import Foundation

enum StatusType {
    case idle, working, done
}

class ProcessCollectionViewCell: UICollectionViewCell {
    
    private var status: StatusType?
    let customFont = CustomFont()
    
    @IBOutlet weak var processLabel: UILabel! {
        didSet {
            processLabel.font = customFont.getCustomFontType(type: .Regular, size: 16)
        }
    }
    @IBOutlet weak var statusIndicator: UIView! {
        didSet {
            statusIndicator.backgroundColor = UIColor.clear
            statusIndicator.contentMode = .center
        }
    }
    var doneImage = UIImageView()
    var actInd = UIActivityIndicatorView()
    
    func setProcessContent(text: String) {
        processLabel.text = text
    }
    
    func setCellStatus(statusType: StatusType) {
        setStatusIndicator(statusType: statusType ?? StatusType.idle)
    }
    
    func setStatusIndicator(statusType: StatusType) {
        switch statusType {
        case .idle:
           // print("\(String(describing: processLabel.text)) \(statusType)")
            processLabel.alpha = 0.4
            
            //Set indicator view to nothing
            statusIndicator.isHidden = true
            break
        case .working:
           // print("\(String(describing: processLabel.text)) \(statusType)")
            processLabel.alpha = 1.0
            
            // Set indicator view to indicator view image
            statusIndicator.isHidden = false
            statusIndicator.addSubview(actInd)
            actInd.startAnimating()
            break
        case .done:
            // print("\(String(describing: processLabel.text)) \(statusType)")
            doneImage.image = UIImage(named: "Checkmark")
            doneImage.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            processLabel.alpha = 0
            
            // Set indicator view to checkmark
            statusIndicator.isHidden = false
            actInd.stopAnimating()
            actInd.isHidden = true
            UIView.animate(withDuration: 1) {
                self.statusIndicator.addSubview(self.doneImage)
            }
            UIView.animate(withDuration: 1.5) {
                self.statusIndicator.alpha = 0
            }
            
            break
        }
    }
    
}
