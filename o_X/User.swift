//
//  User.swift
//  o_X
//
//  Created by Jason Brill on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class User {
    init(email: String, password: String) {
        self.email = email;
        self.password = password;
    }
    
    var email: String;
    var password: String;
}
