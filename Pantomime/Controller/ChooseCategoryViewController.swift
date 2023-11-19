//
//  ChooseCategoryViewController.swift
//  Pantomime
//
//  Created by MahyR Sh on 4/22/23.
//

import UIKit

protocol CategoryNameDelegate{
    func category() -> String
}

class ChooseCategoryViewController: UIViewController {
    
    var dataSource: [String] = ["Random", "+18", "Animal", "Object", "Food", "Football", "Sport", "Movie", "Job", "Place", "Tech", "Country City", "Proverb"]
    
    var categoryName = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: "+18Word") {
            dataSource.remove(at: 1)
        }
    }
}

extension ChooseCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCollectionViewCell {
            
            countryCell.configure(with: dataSource[indexPath.row])
            cell = countryCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Play!", message: "Are you ready to play in the \(dataSource[indexPath.row]) category?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {  (alertAction) in
            self.categoryName = self.dataSource[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Play") as! PlayViewController
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            self.show(vc, sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: {(alertAction) in
        }))
        self.present(alert, animated: true)
    }
}

extension ChooseCategoryViewController: CategoryNameDelegate {
    
    func category() -> String {
        return categoryName
    }
}
