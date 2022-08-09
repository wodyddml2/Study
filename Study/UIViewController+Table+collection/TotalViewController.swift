import UIKit

class TotalViewController: UIViewController {
    @IBOutlet weak var totalTableView: UITableView!
    let list: [[Int]] = [
        [Int](1...10),
        [Int](50...55),
        [Int](4...14),
        [Int](7...12)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTableView.delegate = self
        totalTableView.dataSource = self

    }
    

}

extension TotalViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell", for: indexPath) as? TotalTableViewCell else {return UITableViewCell()}
        
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.tag = indexPath.section

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 3.5 + 28
    }
    
}

extension TotalViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TotalCollectionViewCell", for: indexPath) as? TotalCollectionViewCell else {return UICollectionViewCell()}
        cell.cardView.contentLabel.text = "\(list[collectionView.tag][indexPath.item])"
    
        return cell
    }
    
    
}
