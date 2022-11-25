//
//  helpers.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import Foundation
import UIKit
// extend UITextField class, draw a underline
extension UITextField {
    
    func underlined() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.systemBlue.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}

// extend UITextView class, draw a underline
extension UITextView {
    func underlined() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.systemBlue.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
