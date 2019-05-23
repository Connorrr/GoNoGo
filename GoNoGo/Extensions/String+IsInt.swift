//
//  String+IsInt.swift
//  GoNoGo
//
//  Created by Connor Reid on 23/5/19.
//  Copyright © 2019 Connor Reid. All rights reserved.
//

import Foundation

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
