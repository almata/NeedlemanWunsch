//
//  ViewController.swift
//  NeedlemanWunsch
//
//  Created by Albert Mata Guerra on 20/12/2017.
//  Copyright © 2017 Albert Mata Guerra. All rights reserved.
//

import UIKit

// A LA LÍNIA allLabels[i][j] = cell CAL REPASSAR QUINES CEL·LES CAL GUARDAR I QUINES NO CAL, SEGONS LES
// ANIMACIONS QUE ES TINGUI INTENCIÓ DE FER DESPRÉS.

class ViewController: UIViewController {

    //var input1 = "TGCTCGTA"
    //var input2 = "TTCATA"
    var alignment = needlemanWunsch(input1: "TGCTCGTA", input2: "TTCATA")
    
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var matchText: UITextField!
    @IBOutlet weak var substitutionText: UITextField!
    @IBOutlet weak var gapText: UITextField!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var resultStackView: UIStackView!
    
    var allLabels: [[GridCell]] = []
    //var scoreLabels: [[UILabel]] = [] segurament quedarà com variable interna d'on sigui, sent subconjunt d'allLabels
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainGrid()
        createResultGrid()
    }

    @IBAction func run() {
        
    }
    
    @IBAction func demonstrate() {
        
    }
    
    private func createMainGrid() {
        let seq1 = Array(alignment.input1) // Horizontal, so its length sets number of columns (j)
        let seq2 = Array(alignment.input2) // Vertical, so its length sets number of rows (i)

        for _ in 0...seq2.count + 1 {
            allLabels.append(Array(repeatElement(GridCell(), count: seq1.count + 2)))
        }
        
        for i in 0...seq2.count + 1 {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 1
            mainStackView.addArrangedSubview(stack)
            
            for j in 0...seq1.count + 1 {
                let cell = GridCell()
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
                    customize(cell, isHeader: false)
                    allLabels[i][j] = cell
                }
                stack.addArrangedSubview(cell)
            }
        }
    }
    
    private func createResultGrid() {
        addResultRowFor(alignment.output1)
        addResultRowFor(alignment.output2)
    }
    
    private func addResultRowFor(_ output: String) {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 1
        resultStackView.addArrangedSubview(stack)
        
        let seq = Array(output)
        for k in 0..<seq.count {
            let cell = GridCell()
            cell.text = String(seq[k])
            customize(cell, isHeader: true)
            stack.addArrangedSubview(cell)
        }
    }
    
    private func customize(_ cell: GridCell, isHeader: Bool) {
        if isHeader {
            cell.mainLabel.font = UIFont(name:"Avenir-Medium", size: 30)
            cell.view.backgroundColor = .white
        } else {
            cell.color = .darkGray
        }
    }
    
}
