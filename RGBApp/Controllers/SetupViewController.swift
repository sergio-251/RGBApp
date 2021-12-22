//
//  ViewController.swift
//  RGBApp
//
//  Created by Sergey Efimov on 14.12.2021.
//

import UIKit

class SetupViewController: UIViewController, UITextFieldDelegate {
    
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateView(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateView(textField)
        return true
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
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
    
    private func validTextFieldValue(text: String, defaultColor: Float) -> Float {
        if let number = Float(text), number >= 0.0 && number <= 1.0 {
            return number
        }
        showAlert(title: "Wrong number format!", message: "Please, repeat number input")
        return defaultColor
    }
    
    private func showAlert(
        title: String = "",
        message: String = "",
        buttonType: String = "OK"
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        present(alert, animated: true)
        let okAction = UIAlertAction(title: buttonType, style: .default)
        alert.addAction(okAction)
    }
    
    private func updateView(_ sender: UIControl) {
        if let sender = sender as? UISlider {
            switch sender.tag {
            case 0:
                rgbColor.redColor = sender.value
            case 1:
                rgbColor.greenColor = sender.value
            default:
                rgbColor.blueColor = sender.value
            }
        }
        if let sender = sender as? UITextField {
            switch sender.tag {
            case 0:
                rgbColor.redColor = validTextFieldValue(
                    text: sender.text ?? String(rgbColor.redColor),
                    defaultColor: rgbColor.redColor
                )
            case 1:
                rgbColor.greenColor = validTextFieldValue(
                    text: sender.text ?? String(rgbColor.greenColor),
                    defaultColor: rgbColor.greenColor
                )
            default:
                rgbColor.blueColor = validTextFieldValue(
                    text: sender.text ?? String(rgbColor.blueColor),
                    defaultColor: rgbColor.blueColor
                )
            }
        }
        updateUI()
        SetupViewController.setColor(to: viewColor, with: rgbColor)
    }
}

