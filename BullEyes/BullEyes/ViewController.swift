//
//  ViewController.swift
//  BullEyes
//
//  Created by Dung Nguyen on 12/27/18.
//  Copyright © 2018 dapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showAlert(){
        //print("Hello");
        let alert = UIAlertController(title: "Hello, World", message: "This is my first app", preferredStyle: .alert)
        let action = UIAlertAction(title: "Awsome", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert,animated:true,completion: nil);
    }
   

}

