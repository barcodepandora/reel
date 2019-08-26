//
//  WelcomeViewController.swift
//  Reel
//
//  Created by Juan Manuel Moreno on 25/08/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

@IBDesignable class GradientView: UIView {
    
    @IBInspectable weak var startColor: UIColor! {
        return UIColor(red: 255/255, green: 200/255, blue: 0/255, alpha: 0.8)
    }
    @IBInspectable var endColor: UIColor! {
        return UIColor(red: 255/255, green: 50/255, blue: 100/255, alpha: 0.8)
    }
    @IBInspectable var vertical: Bool = false
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    private func setupGradient() {
        let gradient = self.layer as! CAGradientLayer
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.endPoint = vertical ? CGPoint(x: 0, y: 0) : CGPoint(x: 0, y: 1)
    }
    
}

class GradientViewForWelcome: GradientView {
    @IBInspectable override var startColor: UIColor! {
        return UIColor(red: 255/255, green: 200/255, blue: 0/255, alpha: 0.8)
    }
    @IBInspectable override var endColor: UIColor! {
        return UIColor(red: 255/255, green: 50/255, blue: 100/255, alpha: 0.8)
    }
}
