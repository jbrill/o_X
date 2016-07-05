//
//  User.swift
//  o_X
//
//  Created by Jason Brill on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class User {
    init(email: String, token: String, client: String) {
        self.email = email
        self.token = token
        self.client = client
    }
    
    var email: String
    var token:String
    var client:String
}
