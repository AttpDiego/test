//
//  ViewController.swift
//  test
//
//  Created by Diego Schaaf on 1/6/22.
//  Copyright © 2022 Diego Schaaf. All rights reserved.
//
/* This is code designed to generate occasional color display that does not match
    user selected color and, if the reaction input is given at the wrong color
    will result in a fault.
    Non-valid color should not display too often, just enough to make user assess if
    the displayed color is the one they chose rather than auromatically giving reaction input
    It is limited to repeating non-valid color twice before displaying a valid one

*/
import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var squareItem2: UIView!
    @IBOutlet weak var squareItem: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var player: AVAudioPlayer?
    var activePeriod = false
    var clickCount = 1
    var selectedColor = 1
    let colorCondition = 0
    var macroRandom = 0
    var displayColor1 = UIColor.red
    var displayColor2 = UIColor.red
    var numericDisplayColor1 = 100
    var numericDisplayColor2 = 100
    var randomCondition = 0
    var selectedColor1 = 3
    var selectedColor2 = 1
    var generatedColor1 = 1
    var generatedColor2 = 1
    var colorMatch = true
    var convertedColor = 1
    var color1 = 1
    var color2 = 1
    var countRed = 0
    var countGreen = 0
    var countBlue = 0
    var countYellow = 0
    var countBlack = 0
    var lastColor1 = 0
    var lastColor2 = 0
    var repCount1 = 0
    var repCount2 = 0
    var runCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.setTitle("PRESS ME", for: .normal)
    }
    
    
    @IBAction func runTest(_ sender: Any) {
        
            self.runCount = 0
            runAll()
            runCount += 1
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.runAll()
            self.label.text = "Test \(self.runCount)"
           // print ("Action\(self.runCount)")
            self.runCount += 1
                if self.runCount >= 11 {
                    timer.invalidate()
                    }
                }
            }
    
    

    
    
    func runAll () {
//        print ("Last colors \(lastColor1) - \(lastColor2)")
//        print ("Repeat count C1 \(repCount1)")
        randomizeColors1()
        //rotateColors()
        colorSelection()
        colorStatus()
        repStatus1()
        //repStatus2()
        colorCount1 ()
        //count += 1

    }
    
    //response test
//    func rotateColors() {
//        switch runCount {
//        case 1:
//            numericDisplayColor1 = 1
//            numericDisplayColor2 = 1
//        case 2:
//            numericDisplayColor1 = 2
//            numericDisplayColor2 = 2
//        case 3:
//            numericDisplayColor1 = 3
//            numericDisplayColor2 = 3
//        case 4:
//            numericDisplayColor1 = 5
//            numericDisplayColor2 = 5
//        default:
//            numericDisplayColor1 = 4
//            numericDisplayColor2 = 4
//        }
//    }

    
    func randomizeColors1 () {
        macroRandom = Int.random(in:1...2)
        //print("Macro Result = \(macroRandom)")
        color1 = Int.random(in:1...4)
        color2 = Int.random(in:1...4)
        if macroRandom != 1 || repCount1 > 1 {
            numericDisplayColor1 = selectedColor1
            numericDisplayColor2 = selectedColor2
        }
        else {
            numericDisplayColor1 = color1
            numericDisplayColor2 = color2
           
        }
    }
    
    func blackFlash () {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
        self.squareItem.backgroundColor = .black
        self.squareItem2.backgroundColor = .black
            print("flash")
            print (self.activePeriod)
        }
    }
    
    func colorSelection () {
        
//        print("Final numericDisplay1 before execution \(numericDisplayColor1)")
//        print("Final numericDisplay2 before execution \(numericDisplayColor2)")
        
        switch numericDisplayColor1 {
        case 1:
            displayColor1 = UIColor.red
        case 2:
            displayColor1 = UIColor.green
        case 3:
            displayColor1 = UIColor.blue
        case 4:
            displayColor1 = UIColor.yellow
        case 5:
            displayColor1 = UIColor.black
        default:
            print ("error in func colorSelection")
        }
        
        switch numericDisplayColor2 {
        case 1:
            displayColor2 = UIColor.red
        case 2:
            displayColor2 = UIColor.green
        case 3:
            displayColor2 = UIColor.blue
        case 4:
            displayColor2 = UIColor.yellow
        case 5:
            displayColor2 = UIColor.black
        default:
            print ("error in func colorSelection2")
    }
                blackFlash()
        squareItem.backgroundColor = displayColor1
        squareItem2.backgroundColor = displayColor2
    }
    
    func colorStatus () {
        if numericDisplayColor1 == selectedColor1 && numericDisplayColor2 == selectedColor2 {
            colorMatch = true
            activePeriod = true
            
        }
        else {
            activePeriod = false
        }
        print ("Color 1 match/activePeriod \(activePeriod)")
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "3250Hz", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }

        func colorCount1 () {
            switch numericDisplayColor1 {
           case 1: countRed += 1
           case 2: countGreen += 1
           case 3: countBlue += 1
           case 4: countYellow += 1
           case 5: countBlack += 1
           default:
                print ("Error in colorCount1")
        }
   
            switch numericDisplayColor2 {
            case 1: countRed += 1
            case 2: countGreen += 1
            case 3: countBlue += 1
            case 4: countYellow += 1
            case 5: countBlack += 1
            default:
                print ("Error in colorCount2")
            }

//        print ("Red \(countRed)")
//        print ("Green \(countGreen)")
//        print ("Blue \(countBlue)")
//        print ("Yellow \(countYellow)")
            lastColor1 = numericDisplayColor1
            lastColor2 = numericDisplayColor2
                    //print ("Colors in colorCount \(lastColor1) - \(lastColor2)")
    }

// Checking for repeats in single color
    func repStatus1 () {
        //print ("Last colors \(lastColor1)")
        if numericDisplayColor1 != selectedColor1 || numericDisplayColor2 != selectedColor2 {
            repCount1 += 1
        }
        else {
            repCount1 = 0
        }
//        print ("Last colors \(lastColor1) - \(lastColor2)")
//        print ("Repeat count C1 \(repCount1)")
    }
    
    // Checking for repeats in non-active color combinations
    
//    func repStatus2 () {
//
//        if numericDisplayColor1 != selectedColor1 {
//            repCount2 += 1
//        }
//        else {
//            repCount2 = 0
//        }
//        print ("Repeat count C2 \(repCount2)")
//        print ("Last colors \(lastColor1) - \(lastColor2)")
//    }
//
}



