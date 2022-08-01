//
//  ViewController.swift
//  Example
//
//  Created by rohit arora on 02/08/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var progressRing: RAProgressRing!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressRing.trackColor = .red.withAlphaComponent(0.25)
        progressRing.circleColor = .red
        progressRing.animationDuration = 3
        setAnimation()
        // Do any additional setup after loading the view.
    }
    
    func setAnimation() {
        progressRing.setProgress(1, animated: true)
    }
}

