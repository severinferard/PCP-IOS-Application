//
//  Personnel.swift
//  NewspaperExample
//
//  Created by Séverin FERARD on 25/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

class Personnel {
    
    var name: String
    let role: String
    let phoneChar: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "-"]
    
    init(name: String, role: String) {
        self.name = name
        self.role = role
        self.name.removeAll(where: {phoneChar.contains($0)})
    }

}
