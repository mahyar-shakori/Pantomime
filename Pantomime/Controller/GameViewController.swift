//
//  StartGameViewController.swift
//  Pantomime
//
//  Created by MahyR Sh on 4/22/23.
//

import UIKit

class GameViewController: UIViewController, UITextViewDelegate {
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        startAgainButton.isHidden = true
        celebrateImageGif.isHidden = true
        winnerNameLabel.isHidden = true
        list = InitGameDelegate?.setGroupNumber() ?? []
        GameViewController.groupNumber = InitGameDelegate?.setGroupNumber().count ?? 2
        GameViewController.time = InitGameDelegate?.setTime() ?? 90
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gameTableView.reloadData()
                
        if Score_NewRoundNumberDelegate?.newRoundNumber() ?? 1 <= (InitGameDelegate?.setRoundNumber() ?? 1) {
            roundNumberLabel.text = "Round \(Score_NewRoundNumberDelegate?.newRoundNumber() ?? 1)/\(InitGameDelegate?.setRoundNumber() ?? 1)"
        } else {
            roundNumberLabel.text = "Round \((Score_NewRoundNumberDelegate?.newRoundNumber() ?? 1)-1)/\(InitGameDelegate?.setRoundNumber() ?? 1)"
            
            self.gameTableView.layer.opacity = 0.5
            celebrateImageGif.isHidden = false
            winnerNameLabel.isHidden = false
            celebrateImageGif.loadGif(name: "CelebGif")
            winnerNameLabel.text = "folani is winner"
            self.view.bringSubviewToFront(winnerNameLabel)
            self.view.bringSubviewToFront(celebrateImageGif)
            startAgainButton.isHidden = false
            startButton.isHidden = true
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return InitGameDelegate?.setGroupNumber().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") as! TeamTableViewCell
        
        cell.groupNameTitleLabel.textContainer.maximumNumberOfLines = 1
        cell.groupNameTitleLabel.delegate = self
        
        let groupNumber = list[indexPath.row]
        cell.groupNameTitleLabel.text = "Group \(groupNumber)"
        cell.groupScoreTitleLabel.text = "\(Score_NewRoundNumberDelegate?.setScoreNumber() ?? 0)"
        
        return cell
    }
}
