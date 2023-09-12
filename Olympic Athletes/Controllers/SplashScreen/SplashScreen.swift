//
//  SplashScreen.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import UIKit

class SplashScreen: UIViewController {

    var window: UIWindow?
    @IBOutlet weak var mAppName: UILabel!
    
    @IBOutlet weak var mCopyrightText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        mAppName.text = "Olympic Athletes"
        
        // Do any additional setup after loading the view.
        var timer = Timer()
        // cancel the timer in case the button is tapped multiple times
        timer.invalidate()
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
       
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        self.mCopyrightText.text = NSString(format: "©%d %@", year, "Olympic Athletes. All Rights Reserved." ) as String
    }
    
    @objc func delayedAction()
    {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Loginvc = storyboard.instantiateViewController(withIdentifier: "HomePageID") as! HomePage
            self.navigationController?.pushViewController(Loginvc, animated: false)

            
           
            
        }
    }

    
   
    
}
