//
//  IntroViewController.swift
//  Pantomime
//
//  Created by Mahyar on 11/14/23.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        descriptionLabel.attributedText = descriptionLabel.justifyLabel(str: (descriptionLabel.text!))
    }
    
    @IBAction func goNextPage(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isLogin")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
}
