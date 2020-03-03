//
//  LoginViewController.swift
//  NewspaperExample
//
//  Created by Séverin FERARD on 29/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var UsernameLabel: UITextField!
    @IBOutlet weak var PasswordLabel: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var ImageViewLogo: UIImageView!
    
    let Logo = UIImage(named: "LogoPC2")
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -250 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
        
        UsernameLabel.layer.borderWidth = 1.0
        UsernameLabel.layer.cornerRadius = 6
        UsernameLabel.layer.masksToBounds = true
        UsernameLabel.layer.borderColor = UIColor.orange.cgColor
        
        PasswordLabel.layer.borderWidth = 1.0
        PasswordLabel.layer.cornerRadius = 6
        PasswordLabel.layer.masksToBounds = true
        PasswordLabel.layer.borderColor = UIColor.orange.cgColor
        
        LoginButton.layer.borderWidth = 1.0
        LoginButton.layer.cornerRadius = 9
        LoginButton.layer.masksToBounds = true
        LoginButton.layer.borderColor = UIColor.blue.cgColor
        
        ImageViewLogo.image = Logo
        
    }
    
    @IBAction func LogginButtonAction(_ sender: UIButton) {
//        UserID = UsernameLabel.text
//        Userpassword = PasswordLabel.text
        isUserConnected = true
        
        defaults.set(UsernameLabel.text, forKey: defaultsKeys.UserID)
        defaults.set(PasswordLabel.text, forKey: defaultsKeys.UserPassword)
        defaults.set("true", forKey: defaultsKeys.isUserConnected)
        print("login", UsernameLabel.text, PasswordLabel.text)
        
        var UserID = defaults.string(forKey: defaultsKeys.UserID)
        var UserPassword = defaults.string(forKey: defaultsKeys.UserPassword)
        print("login2", UserID, UserPassword)

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "EventsTableViewController") as! EventsTableViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)

        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "EventsTableViewController") as! EventsTableViewController
//        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    
    
    
    
}

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear

    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0, 1.5]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
//        [0.3, 1.0]
    }
}

