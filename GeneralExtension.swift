//
//  File.swift
//  TestingApp
//
//  Created by Raunaque Quaiser on 07/10/19.
//  Copyright © 2019 Raj Maurya. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIView{
    
    @IBInspectable var borderColor:UIColor{
        get{
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.white.cgColor)
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var redius:CGFloat{
        get{
            return  self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    
    
    
    @IBInspectable var borderWidth:CGFloat{
        get{
            return self.layer.borderWidth
        }
        set{
            return self.layer.borderWidth = newValue
        }
    }
}


