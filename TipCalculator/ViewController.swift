//
//  ViewController.swift
//  TipCalculator
//
//  Created by Colin on 9/30/15.
//  Copyright © 2015 ccross. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var subtotalTextField: UITextField!
    @IBOutlet weak var amountofPeopleTextField: UITextField!
    
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var fifteenPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButton: UIButton!
    @IBOutlet weak var twentyFivePercentButton: UIButton!
    
    
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var tipPerPersonLabel: UILabel!
    @IBOutlet weak var billPerPersonLabel: UILabel!
    
    @IBOutlet weak var downArrowButton: UIButton!
    @IBOutlet weak var upArrowButton: UIButton!
    
    
    var tipPercentage : Double = 0
    var subtotal : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func calculateTip(percentage : Double) {
        subtotalTextField.text = "$" + String(format: "%.2f", subtotal)
        var people = (amountofPeopleTextField.text! as NSString).integerValue
        people = clamp(1, variable: people)
        amountofPeopleTextField.text = "\(people)"
        
        
        let dpeople = (Double)(people)
        
        let tip = subtotal * percentage
        let bill = subtotal + tip
        
        totalTipLabel.text = "$" + String(format: "%.2f", tip)
        totalBillLabel.text = "$" + String(format: "%.2f", bill)
        tipPerPersonLabel.text = "$" + String(format: "%.2f",  tip / dpeople)
        billPerPersonLabel.text = "$" + String(format: "%.2f", bill / dpeople)
    }
    
    func resetImages() {
        tenPercentButton.setImage(UIImage(named: "10_unselected_image"), forState: UIControlState.Normal)
        fifteenPercentButton.setImage(UIImage(named: "15_unselected_image"), forState: UIControlState.Normal)
        twentyPercentButton.setImage(UIImage(named: "20_unselected_image"), forState: UIControlState.Normal)
        twentyFivePercentButton.setImage(UIImage(named: "25_unselected_image"), forState: UIControlState.Normal)
        DismissKeyboard()
    }
    
    @IBAction func tenSelected(sender: AnyObject) {
        resetImages()
        tipPercentage = 0.10
        tenPercentButton.setImage(UIImage(named: "10_selected_image"), forState: UIControlState.Normal)
        calculateTip(tipPercentage)
    }
    
    @IBAction func fifteenSelected(sender: AnyObject) {
        resetImages()
        tipPercentage = 0.15
        fifteenPercentButton.setImage(UIImage(named: "15_selected_image"), forState: UIControlState.Normal)
        calculateTip(tipPercentage)
        
    }
    
    @IBAction func twentySelected(sender: AnyObject) {
        resetImages()
        tipPercentage = 0.20
        twentyPercentButton.setImage(UIImage(named: "20_selected_image"), forState: UIControlState.Normal)
        calculateTip(tipPercentage)
    }
    
    @IBAction func twentyFiveSelected(sender: AnyObject) {
        resetImages()
        tipPercentage = 0.25
        twentyFivePercentButton.setImage(UIImage(named: "25_selected_image"), forState: UIControlState.Normal)
        calculateTip(tipPercentage)
    }
    
    
    @IBAction func decrementPeople(sender: AnyObject) {
        var people = (amountofPeopleTextField.text! as NSString).integerValue
        --people
        people = clamp(1, variable: people)
        amountofPeopleTextField.text = "\(people)"
        calculateTip(tipPercentage)
    }
    
    @IBAction func incrementPeople(sender: AnyObject) {
        var people = (amountofPeopleTextField.text! as NSString).integerValue
        ++people
        amountofPeopleTextField.text = "\(people)"
        calculateTip(tipPercentage)
    }
    
    
    
    //prevents variable from dropping below min value
    //Used so we cannot have 0 or negative people
    func clamp(min : Int, variable : Int) -> Int {
        
        if(variable < min) {
            return min
        }
        else {
            return variable
        }
}

    //Dismisses the keyboard, confirms that user is done typing a subtotal and sets variable
    func DismissKeyboard() {
        if(subtotalTextField.text?.rangeOfString("$") == nil) {
        subtotal = (subtotalTextField.text! as NSString).doubleValue
        }
        calculateTip(tipPercentage)
        view.endEditing(true)
    }
}