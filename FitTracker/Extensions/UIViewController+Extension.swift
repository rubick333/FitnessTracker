//
//  UIViewController+Extension.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 03/04/24.
//

import UIKit

extension UIViewController{
    func addGesture(view:UIView){
        let tap = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
