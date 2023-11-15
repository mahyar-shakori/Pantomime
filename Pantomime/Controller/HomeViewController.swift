//
//  HomeViewController.swift
//  Pantomime
//
//  Created by MahyR Sh on 4/22/23.
//

import UIKit

class HomeViewController: UIViewController, UITextViewDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UserDefaults.standard.set(0, forKey: "roundNumer")
        UserDefaults.standard.set(1, forKey: "newRoundNumer")
    }
    
    @IBAction func familyModeButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "+18Word")
        goNextPage()
    }
    
    @IBAction func friendsModeButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "+18Word")
        goNextPage()
    }
    
    func goNextPage() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateGame") as! CreateGameViewController
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
}


//device size, dataBase, language

// group winner, emtiaz
