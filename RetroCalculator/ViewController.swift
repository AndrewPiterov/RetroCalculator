//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Andrew Piterov on 19/09/2017.
//  Copyright © 2017 Andrew Pierov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    @IBOutlet weak var outputLbl: UILabel!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = "0"
    var rightValStr = ""
    var result = ""
    
    enum Operation: String{
        case Devide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empry"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType:"wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDevidePressed(sender: UIButton){
        processOperation(.Devide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton){
        processOperation(.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton){
        processOperation(.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton){
        processOperation(.Add)
    }

    @IBAction func onEqualPressed(sender: UIButton){
        processOperation(currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(_ operation: Operation){
        playSound()
        if operation != Operation.Empty {
            
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                switch operation{
                case .Add:
                    result = "\((Double(leftValStr)! + Double(rightValStr)!))"
                    break
                case .Devide:
                    result = "\((Double(leftValStr)! / Double(rightValStr)!))"
                    break
                case .Multiply:
                    result = "\((Double(leftValStr)! * Double(rightValStr)!))"
                    break
                case .Subtract:
                    result = "\((Double(leftValStr)! - Double(rightValStr)!))"
                    break
                case .Empty:
                    break
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

