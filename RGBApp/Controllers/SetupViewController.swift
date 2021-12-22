//
//  ViewController.swift
//  RGBApp
//
//  Created by Sergey Efimov on 14.12.2021.
//

import UIKit

class SetupViewController: UIViewController {
    
    @IBOutlet var viewColor: UIView!
    
    @IBOutlet var valueLabels: [UILabel]!
    
    @IBOutlet var sliders: [UISlider]!
    
    @IBOutlet var valueTextFields: [UITextField]!
    
    var rgbColor: RgbColor!
    
    var delegate: SetupViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewColor.layer.cornerRadius = 20
        updateUI()
    }
    
    @IBAction func scrollAction(_ sender: UISlider) {
        updateView(sender)
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColorView(with: rgbColor)
        dismiss(animated: true)
    }
}

//MARK: Static methods
extension SetupViewController {
    static func setColor(to view: UIView, with color: RgbColor) {
        let colorRgb = UIColor(
            red: CGFloat(color.redColor),
            green: CGFloat(color.greenColor),
            blue: CGFloat(color.blueColor),
            alpha: 1
        )
        view.backgroundColor = colorRgb
    }
}

//MARK: Private Methods
extension SetupViewController {
    
    private func setLabelValue(for label: UILabel, with color: Float) {
        label.text = String(format: "%.2f", color)
    }
    
    private func setTextFieldValue(
        for textField: UITextField,
        with color: Float
    ) {
        textField.text = String(format: "%.2f", color)
    }
    
    private func setSliderPosition(for slider: UISlider, with color: Float) {
        slider.value = color
    }
    
    private func updateUI() {
        SetupViewController.setColor(to: viewColor, with: rgbColor)
        for (slider, color) in zip(sliders, rgbColor.getArrayRgbColor()) {
            setSliderPosition(for: slider, with: color)
        }
        for (textField, color) in zip(valueTextFields,
                                      rgbColor.getArrayRgbColor()) {
            setTextFieldValue(for: textField, with: color)
        }
        for (label, color) in zip(valueLabels, rgbColor.getArrayRgbColor()) {
            setLabelValue(for: label, with: color)
        }
        
    }
    
    private func updateView(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            rgbColor.redColor = sender.value
        case 1:
            rgbColor.greenColor = sender.value
        default:
            rgbColor.blueColor = sender.value
        }
        updateUI()
        SetupViewController.setColor(to: viewColor, with: rgbColor)
    }
}

