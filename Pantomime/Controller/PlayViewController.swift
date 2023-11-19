//
//  PlayViewController.swift
//  Pantomime
//
//  Created by MahyR Sh on 4/22/23.
//

import UIKit

protocol Score_NewRoundNumberDelegate{
    func setScoreNumber() -> Int
    func newRoundNumber() -> Int
    func newCurrentIndex() -> Int
}

class PlayViewController: UIViewController {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var showWordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var addTimeButton: UIButton!
    @IBOutlet weak var changeWordButton: UIButton!
    @IBOutlet weak var gameView: UIView!
    
    var delegate: CategoryNameDelegate?
    var countdownTimer: Timer?
    var changeWordButtonFlag = 0
    var scoreResultNumber = 3
    var timer = 0
    var categoryRandomArray = [String]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        categoryNameLabel.text = delegate?.category()
        timer = GameViewController.time
        countdownLabel.text = formatTime(timer)
        randomWord()
        finishButton.isHidden = true
        showWordButton.isHidden = false
        gameView.isHidden = true
        randomWordLabel.isHidden = true
    }
    
    func randomWord() {
    
        if UserDefaults.standard.bool(forKey: "+18Word") {
            categoryRandomArray = animals + foods + objects + countriesAndCities + tech + Places + jobs + football + sports + movies + proverbs
        } else {
            categoryRandomArray = swearWords + animals + foods + objects + countriesAndCities + tech + Places + jobs + football + sports + movies + proverbs
        }
        
        switch delegate?.category() {
        case "Random":
            randomWordLabel.text = categoryRandomArray.randomElement()!
        case "+18":
            randomWordLabel.text = swearWords.randomElement()!
        case "Animal":
            randomWordLabel.text = animals.randomElement()!
        case "Object":
            randomWordLabel.text = objects.randomElement()!
        case "Food":
            randomWordLabel.text = foods.randomElement()!
        case "Football":
            randomWordLabel.text = football.randomElement()!
        case "Sport":
            randomWordLabel.text = sports.randomElement()!
        case "Movie":
            randomWordLabel.text = movies.randomElement()!
        case "Job":
            randomWordLabel.text = jobs.randomElement()!
        case "Place":
            randomWordLabel.text = Places.randomElement()!
        case "Tech":
            randomWordLabel.text = tech.randomElement()!
        case "Country City":
            randomWordLabel.text = countriesAndCities.randomElement()!
        case "Proverb":
            randomWordLabel.text = proverbs.randomElement()!
        default:
            randomWordLabel.text = categoryRandomArray.randomElement()!
        }
    }
    
    @IBAction func showWordButtonTapped(_ sender: UIButton) {
        
        gameView.isHidden = false
        randomWordLabel.isHidden = false
        showWordButton.isHidden = true
    }
    
    @IBAction func PlayButtonTapped(_ sender: UIButton) {
        startTimer()
        playButton.isHidden = true
        finishButton.isHidden = false
        addTimeButton.isEnabled = false
        changeWordButton.isEnabled = false
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        
        endTimer()
    }
    
    @IBAction func changeWordButtonTapped(_ sender: UIButton) {
        randomWord()
        changeWordButtonFlag += 1
        scoreResultNumber -= 1
        
        if changeWordButtonFlag == 1 {
            changeWordButton.isEnabled = false
        }
    }
    
    @IBAction func addTimeButtonTapped(_ sender: UIButton) {
        countdownLabel.text = formatTime(GameViewController.time+30)
        addTimeButton.isEnabled = false
        scoreResultNumber -= 1
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timer > 0 {
            timer -= 1
            countdownLabel.text = formatTime(timer)
        } else {
            endTimer()
        }
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func endTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        gameResultAlert()
        gameResultCalculate()
    }
    
    func gameResultAlert() {
        
        let alert = UIAlertController(title: "Time is over!", message: "Did you answer correctly?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {  (alertAction) in
            if self.categoryNameLabel.text == "Proverb" {
                self.scoreResultNumber += 5
            }
            self.showResultInGamePage()
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: {(alertAction) in
            
            self.scoreResultNumber = 0
            self.showResultInGamePage()
        }))
        self.present(alert, animated: true)
    }
    
    func gameResultCalculate() {
        
        GameViewController.roundNumber += 1
        UserDefaults.standard.set(GameViewController.roundNumber, forKey: "roundNumer")
        GameViewController.currentIndexFlag += 1
        
        if UserDefaults.standard.integer(forKey: "roundNumer") % GameViewController.groupNumber == 0 {
            GameViewController.newRoundNumer += 1
            UserDefaults.standard.set(GameViewController.newRoundNumer, forKey: "newRoundNumer")
            GameViewController.newRoundNumer = UserDefaults.standard.integer(forKey: "newRoundNumer")
        } else {
            GameViewController.newRoundNumer = UserDefaults.standard.integer(forKey: "newRoundNumer")
        }
    }
    
    func showResultInGamePage() {
        
        for controller in self.navigationController!.viewControllers as Array {
            if let vc = controller as? GameViewController {
                vc.Score_NewRoundNumberDelegate = self
                self.navigationController!.popToViewController(vc, animated: true)
                break
            }
        }
    }
}

extension PlayViewController: Score_NewRoundNumberDelegate {
    
    func setScoreNumber() -> Int {
        return scoreResultNumber
    }
    
    func newRoundNumber() -> Int {
        return GameViewController.newRoundNumer
    }
    
    func newCurrentIndex() -> Int {
        return GameViewController.currentIndexFlag
    }
}
