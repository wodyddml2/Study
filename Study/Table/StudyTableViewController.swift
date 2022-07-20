//
//  StudyTableViewController.swift
//  Study
//
//  Created by J on 2022/07/20.
//

import UIKit

class StudyTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var studyTextField: UITextField!
    @IBOutlet weak var studySearchButton: UIButton!
    @IBOutlet weak var studyBackground: UIView!
    
    var studyCell = TableListInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studyTextField.delegate = self
        
        studyBackground.backgroundColor = UIColor(named: "TableColor")
        studyBackground.layer.masksToBounds = true
        studyBackground.layer.cornerRadius = 10
        
        studyTextField.borderStyle = .none
        studyTextField.placeholder = "복습하자"
        
        studySearchButton.setImage(UIImage(systemName: "star"), for: .normal)
        studySearchButton.setTitle("", for: .normal)
        studySearchButton.tintColor = .black
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        studyTextField.resignFirstResponder()
     
         return true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyCell.movie.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTableViewCell", for: indexPath) as! StudyTableViewCell
        cell.study(studyCell.movie[indexPath.row])
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
