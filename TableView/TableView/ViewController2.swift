import UIKit

class ViewController2: UIViewController {
    
}

extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    // 섹션에 셀의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 0.1 // 첫 번째 셀의 헤더 높이
        }
        return 0 // 각 섹션의 헤더는 0으로 하고 푸터로 간격 조정
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // 섹션 푸터의 높이를 조정하는 로직을 구현
        return 10
    }
}
