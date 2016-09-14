//
//  ViewController.swift
//  Uber
//
//  Created by Patrick Lau on 2016-09-14.
//  Copyright © 2016 PLauDev. All rights reserved.
//

import UIKit
import Parse

// PLauDev started with new xcode single view project & inserted Parse code manually

func testParseConnection(table: String, column: String, value: String) {
    
    let testObject = PFObject(className: table)
    testObject[column] = value
    
    testObject.saveInBackgroundWithBlock { (success, error) -> Void in
        if error != nil {
            print("testParseConnection(): \(error)")
        } else {
            print("testParseConnection(): object has been saved")
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // PLauDev test parse connection
        //testParseConnection("test", column: "data", value: "icon")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

