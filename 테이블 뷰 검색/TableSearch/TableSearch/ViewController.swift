import UIKit

class ViewController: UIViewController {
    
    // 테이블 뷰를 구성할 배열 선언
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
    var filteredUni: [String] = [] // 검색 결과를 담을 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchControllerSetting()
    }
    // UISearchController를 만들어 적용
    func searchControllerSetting() {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController // 네비게이션 바에 검색바 적용
        // 검색 내용이 바뀔때 마다 동작을 주기 위해, UISearchResultsUpdating프로토콜을 ViewController가 구현함
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "대학교 검색" // placeholer설정
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
    // 검색 결과가 바뀔때 마다 업데이트 됨
    func updateSearchResults(for searchController: UISearchController) {
        // 검색 바의 텍스트
        guard let searchText = searchController.searchBar.text else { return }
        
        // 검색 바의 텍스트가 포함된 값들만 filteredUni에 담음
        if(searchText != "") {
            filteredUni = uni.filter { $0.contains(searchText) }
            table.reloadData()
        }
    }
    
}

