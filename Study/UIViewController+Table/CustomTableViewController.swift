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

var movieGenre = SubMenuInfo()

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
        mainMenu.backgroundColor = .clear
        subMenu.backgroundColor = .clear
        view.backgroundColor = .systemGray2
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainMenu {
            return Genre.allCases.count
        } else if tableView == subMenu {
            return movieGenre.submenuGenre.count
        } else {
            return 0
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mainCell = mainMenu.dequeueReusableCell(withIdentifier: MainTableViewCell.mainIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        guard let subCell = subMenu.dequeueReusableCell(withIdentifier: SubTableViewCell.subIdentifier, for: indexPath) as? SubTableViewCell else {
            return UITableViewCell()
        }
        if tableView == mainMenu {
            mainCell.mainTitle.text = Genre.allCases[indexPath.row].mainGenre
//            mainCell.backgroundColor = .clear
            return mainCell
        } else if tableView == subMenu {
            subCell.subTitle.text = movieGenre.submenuGenre[indexPath.row].title
            let imageValue = movieGenre.submenuGenre[indexPath.row].click ? "checkmark.square" : "checkmark.square.fill"
            subCell.checkButtonStyle(imageValue)
            subCell.checkButton.tag = indexPath.row
            subCell.checkButton.addTarget(self, action: #selector(subGenreButtonClicked), for: .touchUpInside)
//            subCell.backgroundColor = .clear
            subMenu.isHidden = true
            return subCell
        } else {
            return mainCell
        }
    }
    
    @objc func subGenreButtonClicked(sender:UIButton) {
        movieGenre.submenuGenre[sender.tag].click = !movieGenre.submenuGenre[sender.tag].click
        subMenu.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        subMenu.isHidden = false
    }
}
