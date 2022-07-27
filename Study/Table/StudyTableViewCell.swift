//
//  StudyTableViewCell.swift
//  Study
//
//  Created by J on 2022/07/20.
//

import UIKit

class StudyTableViewCell: UITableViewCell {
    @IBOutlet weak var studyImage: UIImageView!
    @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var studyBackground: UIView!
    
    
    func study(_ info: TableList) {
        studyBackground.backgroundColor = UIColor(named: "TableColor")
        studyBackground.layer.masksToBounds = true
        studyBackground.layer.cornerRadius = 10
        
        studyImage.image = UIImage(named: info.poster)
        studyImage.contentMode = .scaleAspectFill
        
        studyLabel.text = info.title
        studyButton.setTitle("", for: .normal)
        studyButton.tintColor = .black
       
    }
    
    

}
