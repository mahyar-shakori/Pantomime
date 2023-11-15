//
//  CreateGameViewController.swift
//  Pantomime
//
//  Created by MahyR Sh on 4/22/23.
//

import UIKit

protocol InitGameDelegate{
    func setGroupNumber() -> Array<Int>
    func setRoundNumber() -> Int
    func setTime() -> Int
}

class CreateGameViewController: UIViewController {
    
    @IBOutlet weak var addGroupButton: UIButton!
    @IBOutlet weak var subtractGroupButton: UIButton!
    @IBOutlet weak var numberOfGroupsLabel: UILabel!
    @IBOutlet weak var addRoundButton: UIButton!
    @IBOutlet weak var subtractRoundButton: UIButton!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    @IBOutlet weak var addTimeButton: UIButton!
    @IBOutlet weak var subtractTimeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var numberOfGroupsFlag = 2
    var numberOfRoundsFlag = 1
    var timeFlag = 90
    var groupNumber = [1,2]
    var roundNumber = 1
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGroupButton.layer.cornerRadius = 0.5 * addGroupButton.bounds.size.width
        subtractGroupButton.layer.cornerRadius = 0.5 * subtractGroupButton.bounds.size.width
        addRoundButton.layer.cornerRadius = 0.5 * addRoundButton.bounds.size.width
        subtractRoundButton.layer.cornerRadius = 0.5 * subtractRoundButton.bounds.size.width
        addTimeButton.layer.cornerRadius = 0.5 * addTimeButton.bounds.size.width
        subtractTimeButton.layer.cornerRadius = 0.5 * subtractTimeButton.bounds.size.width
        numberOfGroupsLabel.text = String(numberOfGroupsFlag)
        numberOfRoundsLabel.text = String(numberOfRoundsFlag)
        timeLabel.text = formatTime(timeFlag)
    }

    @IBAction func addGroupButtonTapped(_ sender: Any) {
        
        numberOfGroupsFlag += 1
        groupNumber.append(numberOfGroupsFlag)
        numberOfGroupsLabel.text = String(numberOfGroupsFlag)
    }
    
    @IBAction func subtractGroupButtonTapped(_ sender: Any) {
        
        if numberOfGroupsFlag > 2 {
            numberOfGroupsFlag -= 1
            groupNumber.removeLast()
            numberOfGroupsLabel.text = String(numberOfGroupsFlag)
        }
    }
    
    @IBAction func addRoundButtonTapped(_ sender: Any) {
        
        numberOfRoundsFlag += 1
        numberOfRoundsLabel.text = String(numberOfRoundsFlag)
        roundNumber = numberOfRoundsFlag
    }
    
    @IBAction func subtractRoundButtonTapped(_ sender: Any) {
        
        if numberOfRoundsFlag > 1 {
            numberOfRoundsFlag -= 1
            numberOfRoundsLabel.text = String(numberOfRoundsFlag)
            roundNumber = numberOfRoundsFlag
        }
    }
    
    @IBAction func addTimeButtonTapped(_ sender: Any) {
        
        timeFlag += 30
        timeLabel.text = formatTime(timeFlag)
        roundNumber = numberOfRoundsFlag
    }
    
    @IBAction func subtractTimeButtonTapped(_ sender: Any) {
        
        if timeFlag > 30 {
            timeFlag -= 30
            timeLabel.text = formatTime(timeFlag)
        }
    }
   
    @IBAction func nextPageButtonTapped(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartGame") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        vc.InitGameDelegate = self
        self.show(vc, sender: nil)
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension CreateGameViewController: InitGameDelegate {
    
    func setGroupNumber() -> Array<Int> {
        return groupNumber
    }
    
    func setRoundNumber() -> Int {
        return roundNumber
    }
    
    func setTime() -> Int {
        return timeFlag
    }
}
