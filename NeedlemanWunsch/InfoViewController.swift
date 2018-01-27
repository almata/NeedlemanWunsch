//
//  InfoViewController.swift
//  NeedlemanWunsch
//
//  Created by Albert Mata Guerra on 23/12/2017.
//  Copyright © 2017 Albert Mata Guerra. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var mainText: UITextView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.tintColor = mainColor
        mainText.setContentOffset(.zero, animated: false)
        
        let text = mainText.attributedText.string
        let attributedText = NSMutableAttributedString(attributedString: mainText.attributedText)
        attributedText.addAttribute(.link, value: "https://twitter.com/almata",
                                    range: NSString(string: text).range(of: "@almata", options: []))
        attributedText.addAttribute(.link, value: "https://en.wikipedia.org/wiki/Needleman–Wunsch_algorithm",
                                    range: NSString(string: text).range(of: "Wikipedia", options: []))
        mainText.attributedText = attributedText
    }
    
}
