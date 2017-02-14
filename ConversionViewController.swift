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
    
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
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
    override func viewDidAppear(_ animated: Bool) {
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date as Date)

        if hour < 6  || hour > 17 {
            self.view.backgroundColor=UIColor.darkGray
        }
        
    }
    
    @IBAction func fahtrnheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer ){
        textField.resignFirstResponder()
    }
}
