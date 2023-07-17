import UIKit

class ViewController: UIViewController {
    
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
    var filteredUni: [String] = ["서울대학교",
                                 "연세대학교",
                                 "고려대학교",
                                 "한양대학교",
                                 "성균관대학교",
                                 "서강대학교",
                                 "이화여자대학교",
                                 "중앙대학교",
                                 "경희대학교",
                                 "한국외국어대학교"] // 검색 결과를 담을 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchControllerSetting()
    }
    
    func searchControllerSetting() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredUni.count // 검색 중이면 검색 결과를 반환
        } else {
            return uni.count // 그렇지 않으면 전체 데이터 반환
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        if searchController.isActive {
            
            cell.label.text = filteredUni[indexPath.row] // 검색 중이면 검색 결과를 표시
        } else {
            cell.label.text = uni[indexPath.row] // 그렇지 않으면 전체 데이터 표시
        }
        
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterDataWithSearchText(searchText)
            table.reloadData()
        }
    }
    
    func filterDataWithSearchText(_ searchText: String) {
        // 검색어가 포함된 학교만 필터링하여 filteredUni에 저장
        filteredUni = uni.filter { $0.contains(searchText) }
    }
}

