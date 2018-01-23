//
//  ViewController.swift
//  NeedlemanWunsch
//
//  Created by Albert Mata Guerra on 20/12/2017.
//  Copyright © 2017 Albert Mata Guerra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var alignment = needlemanWunsch(input1: "TGCTCGTA", input2: "TTCATA")
    
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var matrixView: UIView!
    @IBOutlet weak var alignmentView: UIView!
    @IBOutlet weak var matrixViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var alignmentViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var alignmentScoreLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var substitutionLabel: UILabel!
    @IBOutlet weak var gapLabel: UILabel!
    
    let maxCellSize: CGFloat = 40.0
    var match = 5
    var substitution = -2
    var gap = -6
    
    var matrixCells: [[GridCell]] = []
    var alignmentCells: [[GridCell]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        run()
    }
    
    @IBAction func matchChanged(_ sender: UISlider) {
        match = Int(sender.value)
        matchLabel.text = "Match: \(match)"
    }
    
    @IBAction func substitutionChanged(_ sender: UISlider) {
        substitution = Int(sender.value)
        substitutionLabel.text = "Substitution: \(substitution)"
    }
    
    @IBAction func gapChanged(_ sender: UISlider) {
        gap = Int(sender.value)
        gapLabel.text = "Gap: \(gap)"
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        let t = sender.text!
        if t.count > 10 {
            sender.text = String(t[..<t.index(t.startIndex, offsetBy: 10)])
        }
    }
    
    @IBAction func run() {
        endEditingAllTextFields()

        for view in matrixView.subviews { view.removeFromSuperview() }
        for view in alignmentView.subviews { view.removeFromSuperview() }
        
        matrixCells = []
        alignmentCells = []
        
        var input1 = self.firstText.text!
        var input2 = self.secondText.text!
        if input1.count < input2.count { swap(&input1, &input2) }
    
        alignment = needlemanWunsch(input1: input1, input2: input2, match: match, substitution: substitution, gap: gap)

        fillMatrix()
        fillAlignment()
        alignmentScoreLabel.text = "   Alignment (score: \(alignment.score))"
    }
    
    private func endEditingAllTextFields() {
        textFieldDidEndEditing(firstText)
        textFieldDidEndEditing(secondText)
        view.endEditing(true)
    }
    
    private func fillMatrix() {
        let seq1 = Array(alignment.input1) // Horizontal, so its length sets number of columns (j)
        let seq2 = Array(alignment.input2) // Vertical, so its length sets number of rows (i)

        for _ in 0...seq2.count + 1 {
            matrixCells.append(Array(repeatElement(GridCell(), count: seq1.count + 2)))
        }
        
        for i in 0...seq2.count + 1 {
            for j in 0...seq1.count + 1 {
                let cell = GridCell()
                matrixCells[i][j] = cell
                switch (i, j) {
                case (0, 0...1), (0...1, 0):
                    cell.text = ""
                    customize(cell, isHeader: true)
                case (0, 2..<Int.max): // Row for the letters from first sequence
                    cell.text = String(seq1[j - 2])
                    customize(cell, isHeader: true)
                case (2..<Int.max, 0): // Column for the letters from second sequence
                    cell.text = String(seq2[i - 2])
                    customize(cell, isHeader: true)
                default: // Main part of the grid, where we place all numbers
                    cell.text = String(alignment.scores[i - 1][j - 1])
                    cell.origin = alignment.paths[i - 1][j - 1]
                    customize(cell)
                }
            }
        }

        let dim = min(UIScreen.main.bounds.width / CGFloat(matrixCells[0].count), maxCellSize)
        matrixViewHeightConstraint.constant = CGFloat(matrixCells.count) * dim
        putCells(matrixCells, into: matrixView)
    }
    
    private func fillAlignment() {
        let num = Array(alignment.output1).count
        
        for _ in 0...2 { alignmentCells.append(Array(repeatElement(GridCell(), count: num))) }
        
        addOutput(alignment.output1, atRow: 0)
        addOutput(alignment.output2, atRow: 1)
        addOutput(String(repeating: Character(" "), count: num), atRow: 2)
        
        for k in 0..<num {
            if alignmentCells[0][k].text == alignmentCells[1][k].text {
                alignmentCells[2][k].text = String(match)
            } else if alignmentCells[0][k].text == "-" || alignmentCells[1][k].text == "-" {
                alignmentCells[2][k].text = String(gap)
            } else {
                alignmentCells[2][k].text = String(substitution)
            }
        }

        let dim = min(UIScreen.main.bounds.width / CGFloat(alignmentCells[0].count), maxCellSize)
        alignmentViewHeightConstraint.constant = 3 * dim
        putCells(alignmentCells, into: alignmentView)
    }
    
    private func putCells(_ cells: [[GridCell]], into container: UIView) {
        let dim = min(UIScreen.main.bounds.width / CGFloat(cells[0].count), maxCellSize)
        let x = (UIScreen.main.bounds.width - CGFloat(cells[0].count) * dim) / 2
        
        for i in 0..<cells.count {
            for j in 0..<cells[i].count {
                cells[i][j].frame = CGRect(x: x + CGFloat(j) * dim, y: CGFloat(i) * dim, width: dim, height: dim)
                container.addSubview(cells[i][j])
            }
        }
    }
    
    private func addOutput(_ output: String, atRow row: Int) {
        let seq = Array(output)
        for k in 0..<seq.count {
            let cell = GridCell()
            alignmentCells[row][k] = cell
            cell.text = String(seq[k])
            customize(cell, isResult: true)
        }
    }
    
    private func customize(_ cell: GridCell, isHeader: Bool = false, isResult: Bool = false) {
        if isHeader {
            cell.mainLabel.font = UIFont(name:"Avenir-Medium", size: 30)
            cell.view.backgroundColor = .white
        } else if isResult {
            cell.mainLabel.font = UIFont(name:"Avenir-Medium", size: 30)
            cell.color = .darkGray
        } else {
            cell.color = .darkGray
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text! == "" {
            textField.text = "GATTACA"
        }
        
        if textField.text!.count < 3 {
            textField.text = textField.text! + repeatElement("A", count: 3 - textField.text!.count)
        }
    }
    
}
