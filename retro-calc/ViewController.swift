//
//  ViewController.swift
//  retro-calc
//
//  Created by Bryan Ebert on 10/20/15.
//  Copyright © 2015 Bryan Ebert. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Mult = "*"
        case Add = "+"
        case Sub = "-"
        case Empty = "Empty"
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currnetOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    
    }
    
    @IBAction func onClearPress(sender: AnyObject) {
        playSound()
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currnetOperation = Operation.Empty
        outputLbl.text = "0"
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultPress(sender: AnyObject) {
        processOperation(Operation.Mult)
    }
    
    @IBAction func onSubPress(sender: AnyObject) {
        processOperation(Operation.Sub)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperation(currnetOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currnetOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currnetOperation == Operation.Mult {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currnetOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currnetOperation == Operation.Sub {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currnetOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            
            currnetOperation = op
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currnetOperation = op
        }
    }
    
    func playSound() {
        if btnSound.play() {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

