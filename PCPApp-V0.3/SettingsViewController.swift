//
//  SettingsViewController.swift
//  NewspaperExample
//
//  Created by Séverin FERARD on 27/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import UIKit
import os.log

//
//class SettingsViewController: UIViewController{
//    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
//        let attributedString = NSMutableAttributedString(string: string,
//                                                     attributes: [NSAttributedString.Key.font: font])
//        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
//        let range = (string as NSString).range(of: boldString)
//        attributedString.addAttributes(boldFontAttribute, range: range)
//        return attributedString
//    }
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        if isUserConnected {
//
////            let fontsize = CGFloat(20)
////            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontsize)]
////            let attributedString = NSMutableAttributedString(string:Username, attributes:attrs)
////            let normalText = "Connecté en temps que"
////            let normalString = NSMutableAttributedString(string:normalText)
////            normalString.append(attributedString)
//
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 41))
//
//            label.font = UIFont.systemFont(ofSize: 20)
//            label.textColor = .black
//            label.lineBreakMode = .byWordWrapping
//            label.numberOfLines = 3
//
//            label.center.x = self.view.center.x
//            label.center.y = 140
//            label.textAlignment = .center
//
//            label.attributedText = attributedText(withString: String(format: "Connecté en temps que %@", Username), boldString: Username, font: label.font)
//            label.sizeToFit()
//            self.view.addSubview(label)}
//
//            let disconnectButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 41))
//        disconnectButton.setTitleColor(.red, for: .normal)
//        disconnectButton.setTitle("Déconnexion", for: .normal)
//        disconnectButton.center.x = self.view.center.x
//        disconnectButton.center.y = 170
//        disconnectButton.sizeToFit()
//        self.view.addSubview(disconnectButton)
//    }
//}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var TouchIDSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func SwitchValueChanged(_ sender: UISwitch) {
        if TouchIDSwitch.isOn {
            userTouchIDToConnect = true
        } else {
            userTouchIDToConnect = false
        }
    }
}







class LoggedInViewController: UIViewController {
    override func viewDidLoad() {
        
    }
}

class NotLoggedInViewController: UIViewController {
    override func viewDidLoad() {
        
    }
}

