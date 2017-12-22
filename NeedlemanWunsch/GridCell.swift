//
//  GridCell.swift
//  NeedlemanWunsch
//
//  Created by Albert Mata Guerra on 20/12/2017.
//  Copyright © 2017 Albert Mata Guerra. All rights reserved.
//

import UIKit

class GridCell: XibLoadingView {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var diagonalView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var origin: [Origin] = [] {
        didSet {
            for o in origin {
                switch o {
                case .top: topView.isHidden = false
                case .left: leftView.isHidden = false
                case .diagonal: diagonalView.isHidden = false
                }
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
