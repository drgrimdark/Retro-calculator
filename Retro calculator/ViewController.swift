//
//  ViewController.swift
//  Retro calculator
//
//  Created by Mike on 4/7/16.
//  Copyright © 2016 Flamelproducts. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
  
  enum Operation: String {
    case Divide = "/"
    case Multiply = "*"
    case Subtract = "-"
    case Add = "+"
    case Empty = ""
  }

  @IBOutlet weak var outputLbl: UILabel!
  
  var btnSound: AVAudioPlayer!
  
  var runningNumber = ""
  var leftSideStr = ""
  var rightSideStr = ""
  var currentOperation: Operation = Operation.Empty
  var result = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let path = NSBundle.mainBundle().pathForResource( "btn", ofType: "wav")
    let soundUrl = NSURL(fileURLWithPath: path!)
    
    do{
      try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
      btnSound.prepareToPlay()
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
    
  }
  
  @IBAction func onClearPressed (sender: UIButton){
    playSound()
    leftSideStr = ""
    currentOperation = Operation.Empty
    rightSideStr = ""
    runningNumber = ""
    outputLbl.text = ""
  
  }

  @IBAction func numberPressed (btn: UIButton!){
    playSound()
    runningNumber += "\(btn.tag)"
    outputLbl.text = runningNumber
  }

  @IBAction func onDividePressed(sender: AnyObject) {
    processOperation(Operation.Divide)
  }
  
  @IBAction func onMultiplyPressed(sender: AnyObject) {
    processOperation(Operation.Multiply)
  }
  
  @IBAction func onSubtractPressed(sender: AnyObject) {
    processOperation(Operation.Subtract)
  }
  
  @IBAction func onAddPressed(sender: AnyObject) {
    processOperation(Operation.Add)
  }
  
  @IBAction func onEqualPressed(sender: AnyObject) {
    processOperation(currentOperation)
  }
  
  func processOperation(op: Operation) {
    playSound()
    if currentOperation != Operation.Empty{
      if runningNumber != ""{
        rightSideStr = runningNumber
        runningNumber = ""
        if currentOperation == Operation.Multiply {
          result = "\(Double(leftSideStr)! * Double(rightSideStr)!)"
        }else if currentOperation == Operation.Divide {
          result = "\(Double(leftSideStr)! / Double(rightSideStr)!)"
        }else if currentOperation == Operation.Subtract {
          result = "\(Double(leftSideStr)! - Double(rightSideStr)!)"
        }else if currentOperation == Operation.Add {
          result = "\(Double(leftSideStr)! + Double(rightSideStr)!)"
        }
        leftSideStr = result
        outputLbl.text = result
      }
      
    }else{
      leftSideStr = runningNumber
      runningNumber = ""
      currentOperation = op
    }
  }
  
  func playSound() {
    if btnSound.playing{
      btnSound.stop()
    }
    
    btnSound.play()
  }
}

