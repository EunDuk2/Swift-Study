import UIKit

class ViewController3: UIViewController {
    let school:[String] = ["서울대학교", "고려대학교", "연세대학교"]
    var selectedIndexPath: IndexPath?
}

extension ViewController3: UITableViewDelegate, UITableViewDataSource {
    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return school.count
    }
    // 섹션에 셀의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell") as! SchoolCell
        
        cell.section = indexPath.section
        cell.lblSchool.text = school[indexPath.section]
        
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
    // 특정 셀이 선택되었을 때 동작하는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil // 이미 선택된 셀이면 선택 해제
        } else {
            selectedIndexPath = indexPath // 선택한 셀의 indexPath 저장
        }
        // 테이블뷰 업데이트
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    // 테이블 뷰의 셀 높이를 설정하는 메서드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 선택된 셀은 높이를 220로 설정
        if selectedIndexPath == indexPath {
            return 220
        }
        return 45 // 나머지는 45
    }
    
}
