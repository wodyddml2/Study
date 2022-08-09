import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        // DidLoad -> awakeFromNib -> ViewAppear
        // 객체가 초기화된 후 호출
        super.awakeFromNib()
        setupUI()
        
    }

    func setupUI() {
        titleLabel.text = ""
        titleLabel.font = .boldSystemFont(ofSize: 18)
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: contentCollectionView.bounds.width / 4, height: contentCollectionView.bounds.height / 1.3)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }
}
