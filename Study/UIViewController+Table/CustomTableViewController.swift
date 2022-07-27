import UIKit

enum Genre: Int, CaseIterable {
    case kr
    case us
    case jp
    case cn
    case etc
    
    var mainGenre: String {
        switch self {
        case .kr:
            return "한국"
        case .us:
            return "미국"
        case .jp:
            return "일본"
        case .cn:
            return "중국"
        case .etc:
            return "기타"
        }
    }
    
    var subGenre: [SubMenu] {
        switch self {
        case .kr:
            return movieGenre.submenuGenre
        case .us:
            return movieGenre.submenuGenre
        case .jp:
            return movieGenre.submenuGenre
        case .cn:
            return movieGenre.submenuGenre
        case .etc:
            return movieGenre.submenuGenre
        }
    }
    
}

class CustomTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainMenu: UITableView!
    @IBOutlet weak var subMenu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenu.delegate = self
        mainMenu.dataSource = self
        subMenu.delegate = self
        subMenu.dataSource = self
        
        mainMenu.register(UINib(nibName: MainTableViewCell.mainIdentifier, bundle: nil), forCellReuseIdentifier: MainTableViewCell.mainIdentifier)
        subMenu.register(UINib(nibName: SubTableViewCell.subIdentifier, bundle: nil), forCellReuseIdentifier: SubTableViewCell.subIdentifier)


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Genre.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mainCell = mainMenu.dequeueReusableCell(withIdentifier: MainTableViewCell.mainIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        guard let subCell = subMenu.dequeueReusableCell(withIdentifier: SubTableViewCell.subIdentifier, for: indexPath) as? SubTableViewCell else {
            return UITableViewCell()
        }
        
        mainCell.mainTitle.text = Genre.allCases[indexPath.row].mainGenre
        
        return mainCell
    }
}
