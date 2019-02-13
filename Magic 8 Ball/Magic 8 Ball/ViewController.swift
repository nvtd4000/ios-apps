//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Dung Nguyen on 12/29/18.
//  Copyright © 2018 dapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    var randomBallNumber:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newBallImage()
    }


    @IBAction func askQuestionPressed(_ sender: Any) {
        newBallImage()
    }
    
    func newBallImage(){
        randomBallNumber = Int.random(in: 0 ... 4)
        imageView.image = UIImage(named: ballArray[randomBallNumber]);
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        newBallImage()
    }
}

