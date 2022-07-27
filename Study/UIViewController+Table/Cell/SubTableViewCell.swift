
import UIKit

class SubTableViewCell: UITableViewCell {

    static let subIdentifier = "SubTableViewCell"
    
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    func checkButtonStyle(_ imageValue: String) {
        checkButton.layer.masksToBounds = true
        checkButton.layer.cornerRadius = 5
        checkButton.setTitle("", for: .normal)
        checkButton.tintColor = .darkGray
        checkButton.setImage(UIImage(systemName: imageValue), for: .normal)
    }
}
