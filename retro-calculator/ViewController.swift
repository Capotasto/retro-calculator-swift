//
//  ViewController.swift
//  retro-calculator
//
//  Created by Norio Egi on 2/4/16.
//  Copyright © 2016 Capotasto. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runnigNum = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        if runnigNum != "0" {
            runnigNum += "\(btn.tag)"
            outputLbl.text = runnigNum
            
        }else{
            runnigNum = "\(btn.tag)"
            outputLbl.text = runnigNum
        }
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        prosessOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        prosessOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        prosessOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        prosessOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        prosessOperation(currentOperation)
    }
    
    func prosessOperation(op:Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            //Run some math
            if runnigNum != "" {
                
                rightValStr = runnigNum
                runnigNum = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        }else{
            //This is the first time and operator has been press
            leftValStr = runnigNum
            runnigNum = ""
            currentOperation = op
        }
        
    }
    
    func playSound(){
        if btnSound.playing{
            
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

