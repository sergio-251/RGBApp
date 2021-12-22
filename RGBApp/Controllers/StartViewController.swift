//
//  StartViewController.swift
//  RGBApp
//
//  Created by Sergey Efimov on 21.12.2021.
//

import UIKit

protocol SetupViewControllerDelegate {
    func setColorView(with color: RgbColor)
}

class StartViewController: UIViewController  {

    @IBOutlet var viewMain: UIView!
    
    private var currentColor: RgbColor!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setupVC = segue.destination as? SetupViewController else {
            return
        }
        if let color = currentColor {
            setupVC.rgbColor = color
        } else {
            setupVC.rgbColor = getInitRgbColor()
        }
        setupVC.delegate = self
    }
}

//MARK: Delegate
extension StartViewController: SetupViewControllerDelegate {
    func setColorView(with color: RgbColor) {
        currentColor = color
        SetupViewController.setColor(to: viewMain, with: currentColor)
    }
}

//MARK: Private Method
extension StartViewController {
    private func getInitRgbColor() -> RgbColor {
        RgbColor(redColor: 0.25, greenColor: 0.5, blueColor: 0.75)
    }
}
