import UIKit

class TotalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        cardView.posterImageView.backgroundColor = .brown
    }
}
