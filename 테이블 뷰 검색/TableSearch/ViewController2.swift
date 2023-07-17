import UIKit

class ViewController2: UIViewController {
    
    let uni:[String] = [
        "서울대학교",
        "연세대학교",
        "고려대학교",
        "한양대학교",
        "성균관대학교",
        "서강대학교",
        "이화여자대학교",
        "중앙대학교",
        "경희대학교",
        "한국외국어대학교"
    ]
    
    @IBOutlet var table: UITableView!
    var searchController: UISearchController!
    var searchText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchControllerSetting()
    }
    
    func searchControllerSetting() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "대학교 검색"
        searchController.definesPresentationContext = true
    }
}

extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    
    func searchCount() -> Int {
        var count:Int = 0
        
        for i in 0..<uni.count {
            if(uni[i].contains(searchText!)) {
                count += 1
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchCount()
        } else {
            return uni.count // 그렇지 않으면 전체 데이터 반환
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        if searchController.isActive {
            if(uni[indexPath.row].contains(searchText!)) {
                
                cell.label.text = uni[indexPath.row]
            }
        } else {
            cell.label.text = uni[indexPath.row] // 그렇지 않으면 전체 데이터 표시
        }
        
        return cell
    }
}

extension ViewController2: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.searchText = searchText
        table.reloadData()
    }
    
}

