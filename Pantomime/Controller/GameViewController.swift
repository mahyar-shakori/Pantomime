//
//  StartGameViewController.swift
//  Pantomime
//
//  Created by MahyR Sh on 4/22/23.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var roundNumberLabel: UILabel!
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startAgainButton: UIButton!
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var celebrateImageGif: UIImageView!
    
    var InitGameDelegate: InitGameDelegate?
    var Score_NewRoundNumberDelegate: Score_NewRoundNumberDelegate?
    var list = [Int]()
    public static var roundNumber = 0
    public static var newRoundNumer = 1
    public static var groupNumber = 2
    public static var time = 90
    public static var currentIndexFlag = -1
    var groupName = ""
    var groupNameArray = [String]()
    var scoreArray = [Int]()
    var currentIndex = 0
    var scoreResult = 0
    var gameFinish = false
    var gameTurnImage = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAgainButton.isHidden = true
        celebrateImageGif.isHidden = true
        winnerNameLabel.isHidden = true
        list = InitGameDelegate?.setGroupNumber() ?? []
        GameViewController.groupNumber = InitGameDelegate?.setGroupNumber().count ?? 2
        GameViewController.time = InitGameDelegate?.setTime() ?? 90
        
        for i in 1...(InitGameDelegate?.setGroupNumber().count ?? 2) {
            groupNameArray.append("Group \(i)")
            scoreArray.append(0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gameTableView.reloadData()
        
        if Score_NewRoundNumberDelegate?.newRoundNumber() ?? 1 <= (InitGameDelegate?.setRoundNumber() ?? 1) {
            roundNumberLabel.text = "Round \(Score_NewRoundNumberDelegate?.newRoundNumber() ?? 1)/\(InitGameDelegate?.setRoundNumber() ?? 1)"
        } else {
            roundNumberLabel.text = "Round \((Score_NewRoundNumberDelegate?.newRoundNumber() ?? 1)-1)/\(InitGameDelegate?.setRoundNumber() ?? 1)"
            
            self.gameTableView.layer.opacity = 0.3
            celebrateImageGif.isHidden = false
            winnerNameLabel.isHidden = false
            celebrateImageGif.loadGif(name: "CelebGif")
            self.view.bringSubviewToFront(winnerNameLabel)
            self.view.bringSubviewToFront(celebrateImageGif)
            startAgainButton.isHidden = false
            startButton.isHidden = true
            gameFinish = true
        }
        
        if GameViewController.currentIndexFlag >= 0 {
            
            scoreResult = Score_NewRoundNumberDelegate?.setScoreNumber() ?? 0
            scoreArray[currentIndex] = scoreArray[currentIndex] + scoreResult
            
            let indexPath = IndexPath(row: currentIndex, section: 0)
            currentIndex += 1
            if currentIndex >= groupNameArray.count {
                currentIndex = 0
            }
            
            let nextIndexPath = IndexPath(row: currentIndex, section: 0)
            gameTurnImage = "star.fill"
            gameTableView.reloadRows(at: [indexPath, nextIndexPath], with: .fade)
            
            if gameFinish {
                let largestScoreNumber = scoreArray.max()
                let indexLargestScoreNumber = scoreArray.firstIndex(of: largestScoreNumber!)
                let countOfLargestNumber = scoreArray.filter { $0 == largestScoreNumber }.count
                GameViewController.currentIndexFlag = -1
                
                if countOfLargestNumber > 1 {
                    winnerNameLabel.text = "Game equalised"
                } else {
                    winnerNameLabel.text = " \(groupNameArray[indexLargestScoreNumber!]) is winner"
                }
            }
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseCategory") as! ChooseCategoryViewController
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
    
    @IBAction func startAgainButtonTapped(_ sender: Any) {
        
        for controller in self.navigationController!.viewControllers as Array {
            if let vc = controller as? HomeViewController {
                self.navigationController!.popToViewController(vc, animated: true)
                break
            }
        }
    }
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return InitGameDelegate?.setGroupNumber().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") as! TeamTableViewCell
        
        cell.groupNameTitleLabel.text = groupNameArray[indexPath.row]
        cell.groupScoreTitleLabel.text = String (scoreArray[indexPath.row])
        if indexPath.row == currentIndex {
            cell.groupTurnImage.image = UIImage(systemName: gameTurnImage)
        } else {
            cell.groupTurnImage.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Edit Group Name", message: "Enter new name", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "New name"
        }
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            if let newName = alertController.textFields?.first?.text, !newName.isEmpty {
                self?.groupNameArray[indexPath.row] = newName
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
