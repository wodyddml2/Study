//
//  StudyTableViewController.swift
//  Study
//
//  Created by J on 2022/07/20.
//

import UIKit

class StudyTableViewController: UITableViewController, UITextFieldDelegate {
    // class는 참조 타입인 특성으로 property observer를 보통 한 번만 호출
    @IBOutlet weak var studyTextField: UITextField! {
        didSet {
            studyTextField.textAlignment = .center
        }
    }
    @IBOutlet weak var studySearchButton: UIButton!
    @IBOutlet weak var studyBackground: UIView!
    
   // didSet 이용해서 쓸데없는 reloadData 미사용
    var lists = TableListInfo().movie {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
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
        
        tabBarItem.image = UIImage(systemName: "star.fill")
      
        
    }
    //
    // 텍스트 필드에 작성 후 테이블 추가
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        lists.append(TableList(title: studyTextField.text!, poster: lists.randomElement()!.poster, done: true))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        studyTextField.resignFirstResponder()
        lists.append(TableList(title: textField.text!, poster: lists.randomElement()?.poster ?? "benjamin", done: true))
         return true
    }
    //
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTableViewCell", for: indexPath) as! StudyTableViewCell
        cell.study(lists[indexPath.row])
        let buttonValue = lists[indexPath.row].done ? "checkmark.square" : "checkmark.square.fill"
        cell.studyButton.tag = indexPath.row
        cell.studyButton.setImage(UIImage(systemName: buttonValue), for: .normal)
        cell.studyButton.addTarget(self, action: #selector(selectedStudy), for: .touchUpInside)
        return cell
    }
    
    @objc func selectedStudy(sender: UIButton) {
        lists[sender.tag].done = !lists[sender.tag].done
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        
        let detailVC = detailStoryboard.instantiateViewController(withIdentifier: DetailViewController.detailIdentifier)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    
    }
}
