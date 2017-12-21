//
//  GridCell.swift
//  NeedlemanWunsch
//
//  Created by Albert Mata Guerra on 20/12/2017.
//  Copyright © 2017 Albert Mata Guerra. All rights reserved.
//

import UIKit

class GridCell: XibLoadingView {

    enum Origin { case none, top, left, diagonal }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var diagonalView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    // AQUESTA PART CAL REFER-LA UNA MICA PERQUÈ, DE FET, EL CONTROL NO TÉ UN Origin SINÓ UN ARRAY.
    
    var origin: Origin = .top {
        didSet {
            switch origin {
            case .none:
                topView.isHidden = true
                leftView.isHidden = true
                diagonalView.isHidden = true
            case .top:
                topView.isHidden = false
                leftView.isHidden = true
                diagonalView.isHidden = true
            case .left:
                topView.isHidden = true
                leftView.isHidden = false
                diagonalView.isHidden = true
            case .diagonal:
                topView.isHidden = true
                leftView.isHidden = true
                diagonalView.isHidden = false
            }
        }
    }
    
    var text = "" {
        didSet {
            mainLabel.text = text
        }
    }
    
    var color = UIColor.black {
        didSet {
            mainLabel.textColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        diagonalView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
