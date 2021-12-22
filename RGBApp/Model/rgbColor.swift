//
//  rgbColor.swift
//  RGBApp
//
//  Created by Sergey Efimov on 21.12.2021.
//

import Foundation

struct RgbColor {
    var redColor: Float
    var greenColor: Float
    var blueColor: Float
    
    func getArrayRgbColor() -> [Float] {
        [redColor, greenColor, blueColor]
    }
}
