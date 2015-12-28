//
//  ViewController.swift
//  tips
//
//  Created by SergeGuest on 12/15/15.
//  Copyright (c) 2015 SergeGuest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var totalField: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var sharingGuestField: UITextField!
    @IBOutlet weak var guestTipLabel: UILabel!
    @IBOutlet weak var guestTotalLabel: UILabel!
    
    
    @IBOutlet weak var dividerBar: UIView!
    @IBOutlet weak var percentageBar: UISegmentedControl!
    
    // variable declaration and initialization
    var DefaultSegments  = [18, 20, 25]
    var tipPercentage_db: [Double] = [0.0, 0.0, 0.0]
    var tip: Double = 0.0
    var total: Double = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00" // initialize text fields
        totalField.text = "$0.00"
        guestTipLabel.text = "$0.00"
        guestTotalLabel.text = "$0.00"
        sharingGuestField.text = "1"
        
        let defaults = NSUserDefaults.standardUserDefaults() // Get percentage data from memory
        
        // use default percentage value if the memory is empty
        if((defaults.objectForKey("tipPercentageDB")) != nil)
        {
            tipPercentage_db = defaults.objectForKey("tipPercentageDB") as! [Double]
        }
        else // use saved percentages if their value was modified
        {
            for var i = 0; i < DefaultSegments.count; ++i
            {
                tipPercentage_db[i] = Double(DefaultSegments[i])
            }
        }
        
        // display new percentages in their segmented menu
        let segments = tipPercentage_db
        
        for var index = 0; index < tipControl.numberOfSegments; ++index
        {
            tipControl.setTitle("\(Int(segments[index]))%", forSegmentAtIndex: index)
        }
        
        billAmountField.becomeFirstResponder() // make bill amount the first responder
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("view will appear")
        
        // make divider and percentage menu disappear from the view
        dividerBar.center.x  += view.bounds.width
        percentageBar.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
        
        // animate divider and percent menu bar appearance
        UIView.animateWithDuration(0.3, delay: 0.3, options: [], animations: {
            self.dividerBar.center.x -= self.view.bounds.width
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.3, delay: 0.4, options: [], animations: {
            self.percentageBar.center.x += self.view.bounds.width
            }, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sharing(){ // divide total bill and tip amount among guests
        
        let guestNumber = NSString(string: sharingGuestField.text!).doubleValue
        
        if (guestNumber > 0 && sharingGuestField.text != "")
        {
            let guestTip = tip / guestNumber
            let guestTotal = total / guestNumber
            
            // display per guest amounts
            guestTipLabel.text = String(format: "$%0.2f",guestTip)
            guestTotalLabel.text = String(format: "$%0.2f",guestTotal)
        }
    }
    

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        // calculate total bill and tip amount and display them
        let tipID = tipControl.selectedSegmentIndex
        let tipPercentage = Double(tipPercentage_db[tipID])
        
        let billAmount = NSString(string: billAmountField.text!).doubleValue
        tip = billAmount * (tipPercentage * 0.01)
        total = billAmount + tip
        
        tipLabel.text = String(format: "$%0.2f",tip)
        totalField.text  = String(format: "$%0.2f",total)
        
        sharing() // calculate and display per guest bill and tip amounts
        
        }
    
    
    @IBAction func onEditingShareChanged(sender: AnyObject) {
        
        sharing() // adjust per guest bill and tip amount when number of guests is updated
    }
    
    
    
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true) // make keyboard disappear when user tap the screen
    }
    
    

}

