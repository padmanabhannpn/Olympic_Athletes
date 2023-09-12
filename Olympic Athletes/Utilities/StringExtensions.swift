//
//  StringExtensions.swift
//  Soqua
//
//  Created by Francesco Marini on 15/06/2020.
//  Copyright © 2020 Open Gate Srl. All rights reserved.
//

import Foundation
import os

extension String {
    var localized: String? {
        let value = NSLocalizedString(self, comment: "")
        if value != self || NSLocale.preferredLanguages.first == "en" {
            return value
        }
        // Fall back to en
        guard
            let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
            let bundle = Bundle(path: path)
            else { return value }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
    
    var getBool: Bool {
        return (self as NSString).boolValue
    }
    
    var  getInt: Int? {
        guard let intValue = Int(self)  else {
            os_log("Not able to get Int from string", type: .error)
            return nil
        }
        return intValue
    }
    
    var  getDouble: Double? {
        guard let doubleValue = Double(self)  else {
            os_log("Not able to get Double from string", type: .error)
            return nil
        }
        return doubleValue
    }
    
    
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func removeWhitespaces() -> String {
        return self.filter { !$0.isWhitespace }
    }
    
    func splitOnLastOccurrence(ofChar char: Character) -> (String, String)? {
        if let charLastIndex = self.lastIndex(of: char) {
            return (String(self[...charLastIndex]), String(self[charLastIndex...]))
        }
        
        return nil
    }
    
    func isEmpty() -> Bool {
        return self.trim().isEmpty
    }
        
   
   
    func localizedCapitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func countCharacterOccourences(of character: Character) -> Int {
        return reduce(0) {
            $1 == character ? $0 + 1 : $0
        }
    }
    
    func substringRange(of substring: String) -> NSRange? {
        return NSString(string: self).range(of: substring)
    }
}
