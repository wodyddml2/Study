import UIKit

import Kingfisher
class ResultViewController: UIViewController {

    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    @IBOutlet weak var resultTableView: UITableView!
    
    var movieList: [MovieInfo] = []
    
    var genreList: [GenreInfo] = []
   
    var posterList: [[URL]] = []
    
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
        

    }
    
//    func requestTMDB() {
//        RequestAPIManager.shared.requestTMDB(genre: genreList) { movie, poster in
//            self.movieList.append(contentsOf: movie)
//            self.posterList = poster
//            DispatchQueue.main.async {
//                self.resultCollectionView.reloadData()
//            }
//        }
//    }
    
    func requestTMDB() {
        RequestAPIManager.shared.requestGenre { genreList in
            self.genreList = genreList
            DispatchQueue.main.async {
                self.resultTableView.reloadData()
            }
            RequestAPIManager.shared.requestTMDB(genre: genreList) { movie, poster in
                self.movieList.append(contentsOf: movie)
                self.posterList = poster
                DispatchQueue.main.async {
                    self.resultCollectionView.reloadData()
                }
            }
        }
    }

}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == resultCollectionView ? movieList.count : posterList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as? ResultCollectionViewCell else {return UICollectionViewCell()}
        
        if collectionView == resultCollectionView {
            cell.sesacView.posterImageView.kf.setImage(with: movieList[indexPath.item].movieBack)
        } else {
            cell.sesacView.posterImageView.kf.setImage(with: posterList[collectionView.tag][indexPath.item])
        }
        
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

        return genreList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else {return UITableViewCell()}
        
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResultCollectionViewCell")
    
        cell.titleLabel.text = genreList[indexPath.section].genreName
        cell.contentCollectionView.tag = indexPath.section
        cell.contentCollectionView.reloadData()
        
  

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}
