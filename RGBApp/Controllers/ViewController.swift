//
//  ViewController.swift
//  RGBApp
//
//  Created by Sergey Efimov on 14.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewColor: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redScroll: UISlider!
    @IBOutlet var greenScroll: UISlider!
    @IBOutlet var blueScroll: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewColor.layer.cornerRadius = 20
        setColor()
        
    }
    
    
    @IBAction func redScrollAction() {
        redValueLabel.text = String(format: "%.2f", redScroll.value)
    
        setColor()
        
    }
    
    @IBAction func greenScrollAction() {
        greenValueLabel.text = String(format: "%.2f", greenScroll.value)
        
        setColor()
    }
    
    @IBAction func blueScrollAction() {
        blueValueLabel.text = String(format: "%.2f", blueScroll.value)
        
        setColor()
    }
    
    private func setColor() {
        let colorRgb = UIColor(
            red: CGFloat(redScroll.value),
            green: CGFloat(greenScroll.value),
            blue: CGFloat(blueScroll.value),
            alpha: 1
        )
        viewColor.backgroundColor = colorRgb
    }
    

}

