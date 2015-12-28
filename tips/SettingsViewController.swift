//
//  SettingsViewController.swift
//  tips
//
//  Created by SergeGuest on 12/15/15.
//  Copyright (c) 2015 SergeGuest. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tip1Field: UITextField!
    @IBOutlet weak var tip2Field: UITextField!
    @IBOutlet weak var tipThreeField: UITextField!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tip1Label: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip3Label: UILabel!
    
    
    var tipPercentageDB: [Double] = [18.0, 20.0, 25.0]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("view will appear")
        
        // Making labels disapear from the screen
        titleLabel.center.x  -= view.bounds.width
        tip1Label.center.x -= view.bounds.width
        tip2Label.center.x -= view.bounds.width
        tip3Label.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
        
        // Making each label appear one after the other from top to bottom
        UIView.animateWithDuration(0.3, delay: 0.3, options: [], animations: {
            self.titleLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.3, delay: 0.4, options: [], animations: {
            self.tip1Label.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: {
            self.tip2Label.center.x += self.view.bounds.width
            }, completion: nil)

        UIView.animateWithDuration(0.3, delay: 0.6, options: [], animations: {
            self.tip3Label.center.x += self.view.bounds.width
            }, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onEditingChanged1(sender: AnyObject) { // Get and store entry for tip 1
        let tipOne = NSString(string: tip1Field.text!).doubleValue
        tipPercentageDB[0] = tipOne
    }
    
    
    @IBAction func onEditingChanged2(sender: AnyObject) { // Get and store entry for tip 2
        let tipTwo = NSString(string: tip2Field.text!).doubleValue
        tipPercentageDB[1] = tipTwo
        
    }
    
    
    @IBAction func onEditingChangedThree(sender: AnyObject) { // Get and store entry for tip 3
        let tipThree = NSString(string: tipThreeField.text!).doubleValue
        tipPercentageDB[2] = tipThree
        
    }

    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
        // Save settings when user tap the screen
        //print(tipPercentageDB, terminator: "")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(tipPercentageDB, forKey: "tipPercentageDB")
        defaults.synchronize()
        
    }
    
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
