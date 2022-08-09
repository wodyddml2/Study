import UIKit

import Kingfisher
class ResultViewController: UIViewController {

    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    @IBOutlet weak var resultTableView: UITableView!
    
    var posterList: [MovieInfo] = []
    
    var genreList: [Int: String] = [:]
    var genreName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultCollectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResultCollectionViewCell")
        
        resultCollectionView.isPagingEnabled = true
        resultCollectionView.collectionViewLayout = collectionViewLayout()
        requestTMDB()
        requestGenre()
        
        
    }
    
    func requestTMDB() {
        RequestAPIManager.shared.requestTMDB { poster in
            self.posterList.append(contentsOf: poster)
            DispatchQueue.main.async {
                self.resultCollectionView.reloadData()
            }
            
        }
    }
    
    func requestGenre() {
        RequestAPIManager.shared.requestGenre { genreList, genreName in
            self.genreList = genreList
            self.genreName.append(contentsOf: genreName)
            DispatchQueue.main.async {
                self.resultTableView.reloadData()
            }
        }
    }

}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as? ResultCollectionViewCell else {return UICollectionViewCell()}
        
//        cell.sesacView.posterImageView.backgroundColor = color[indexPath.row]
  
        cell.sesacView.posterImageView.kf.setImage(with: posterList[indexPath.item].movieBack)
       
    
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        return layout
    }
    
    
}

extension ResultViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return genreName.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else {return UITableViewCell()}
        
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResultCollectionViewCell")
        cell.titleLabel.text = genreName[indexPath.section]
        cell.contentCollectionView.tag = indexPath.section
        cell.contentCollectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}
