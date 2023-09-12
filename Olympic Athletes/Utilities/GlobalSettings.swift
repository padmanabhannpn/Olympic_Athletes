//
//  GlobalSettings.swift
//  Vilfresh
//
//  Created by PPTS MACMINI on 10/02/20.
//  Copyright © 2020 PPTS. All rights reserved.
//

import Foundation
import UIKit

class GlobalSettings: NSObject {
    
   
    
    static func startLoader(view:UIView )
    {
        DispatchQueue.main.async {
            //view.makeToastActivity(.center)
            
            showUniversalLoadingView(true, loadingText: "Loading Please wait...")
            
        }
    }
    
    static func hideLoader(view:UIView )
    {
        DispatchQueue.main.async {
          //  view.hideToastActivity()
            showUniversalLoadingView(false)
        }
    }
    
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
   static func convertDateString(dateString : String!, fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = sourceFormat
           let date = dateFormatter.date(from: dateString)
           dateFormatter.dateFormat = desFormat
           return dateFormatter.string(from: date!)
       }

    
    
}

func showUniversalLoadingView(_ show: Bool, loadingText : String = "") {
    let existingView = UIApplication.shared.windows[0].viewWithTag(1200)
    if show {
        if existingView != nil {
            return
        }
        let loadingView = makeLoadingView(withFrame: UIScreen.main.bounds, loadingText: loadingText)
        loadingView?.tag = 1200
        UIApplication.shared.windows[0].addSubview(loadingView!)
    } else {
        existingView?.removeFromSuperview()
    }

}



func makeLoadingView(withFrame frame: CGRect, loadingText text: String?) -> UIView? {
    let loadingView = UIView(frame: frame)
    loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    activityIndicator.layer.cornerRadius = 6
    activityIndicator.center = loadingView.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .white
    activityIndicator.startAnimating()
    activityIndicator.tag = 100 // 100 for example

    loadingView.addSubview(activityIndicator)
    if !text!.isEmpty {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
        lbl.center = cpoint
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.text = text
        lbl.tag = 1234
        loadingView.addSubview(lbl)
    }
    return loadingView
}
