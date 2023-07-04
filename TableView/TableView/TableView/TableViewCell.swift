import UIKit

// 프로토콜 선언
protocol TableViewCellDelegate: AnyObject {
    func didTapButton(cellSection: Int?, cellIndex: Int?, name: String?, button: UIButton?)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel! // 레이블
    @IBOutlet var button: UIButton! // 버튼
    
    // 셀의 섹션
    var section:Int?
    // 각 셀의 인덱스
    var index:Int?
    // 델리게이트 사용을 위한 변수 선언
    weak var delegate: TableViewCellDelegate?
    
    // 버튼 액션 함수
    @IBAction func onButton(_ sender: Any) {
        self.delegate?.didTapButton(cellSection: section, cellIndex: index, name: label.text, button: button)
    }
}


// 여기에는 student배열이 없음
