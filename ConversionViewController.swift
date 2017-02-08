//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Alex Hawkins on 2/1/17.
//  Copyright © 2017 Alexander Hawkins. All rights reserved.
//
import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!

    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelciusLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        updateCelciusLabel()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
    
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let AlphaSet = string.rangeOfCharacter(from: NSCharacterSet.letters)
        
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) ||
            AlphaSet != nil {
            return false
        }else {
            return true
        }
    }
        
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var celciusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }else {
            return nil
        }
    }
    
    func updateCelciusLabel() {
        if let celciusValue = celciusValue{
            celciusLabel.text =
                numberFormatter.string(from: NSNumber(value: celciusValue.value))
        }else {
            celciusLabel.text = "???"
        }
    }
    
    @IBAction func fahtrnheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer ){
        textField.resignFirstResponder()
    }
}
