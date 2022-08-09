import UIKit

class DetailViewController: UIViewController {
    static let detailIdentifier = "DetailViewController"
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    let detailPlaceholder = "위의 작성란에 작성해주세요!"
    var detailText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextField.delegate = self
        detailTextView.delegate = self
        
        detailTextView.text = detailPlaceholder
        detailTextView.textColor = .lightGray
        detailTextView.tintColor = .clear
    }

}

extension DetailViewController: UITextFieldDelegate,UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = detailText
            textView.textColor = .black
        }
        
//        textView.isUserInteractionEnabled = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            detailTextView.text = detailPlaceholder
            textView.textColor = .lightGray
        }
        
//        textView.isUserInteractionEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        detailText = textField.text ?? "ss"
        textField.resignFirstResponder()
        
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//    }
}
