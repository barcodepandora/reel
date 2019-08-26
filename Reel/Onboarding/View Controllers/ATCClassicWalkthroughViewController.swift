//
//  ATCClassicWalkthroughViewController.swift
//  DashboardApp
//
//  Created by Florian Marcu on 8/13/18.
//  Copyright © 2018 Instamobile. All rights reserved.
//

import UIKit

class ATCClassicWalkthroughViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var imageContainerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    let model: ATCWalkthroughModel

    init(model: ATCWalkthroughModel,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.model = model
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage.localImage(model.icon, template: true)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
//        imageView.tintColor = .white
        imageContainerView.backgroundColor = .clear

        titleLabel.text = model.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.textColor = .white

        subtitleLabel.attributedText = NSAttributedString(string: model.subtitle)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        subtitleLabel.textColor = .white

//        containerView.backgroundColor = UIColor(hexString: "#3068CC")
    }
}

class GradientViewForOnboarding: GradientView {
    @IBInspectable override var startColor: UIColor! {
        return UIColor(red: 255/255, green: 50/255, blue: 100/255, alpha: 0.8)
    }
    @IBInspectable override var endColor: UIColor! {
        return UIColor(red: 17/255, green: 24/255, blue: 53/255, alpha: 0.8)
    }
}
