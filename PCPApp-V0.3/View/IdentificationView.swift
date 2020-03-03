//
//  IdentificationView.swift
//  NewspaperExample
//
//  Created by Séverin FERARD on 27/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import SwiftUI

import UIKit
class IdentificationView: UIView {
    
    var shouldSetupConstraints = true
    var mainLabel: UILabel!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        if isUserConnected == true {
            
            
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      
    override func updateConstraints() {
      if(shouldSetupConstraints) {
        // AutoLayout constraints
        shouldSetupConstraints = false
      }
      super.updateConstraints()
    }
}
