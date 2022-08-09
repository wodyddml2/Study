import UIKit

class ResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sesacView: SeSAC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sesacView.posterImageView.backgroundColor = .green
    }

}
