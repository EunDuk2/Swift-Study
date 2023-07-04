//
//  ViewController.swift
//  TableView
//
//  Created by EUNSUNG on 2023/06/30.
//

import UIKit

class ViewController: UIViewController {
    
    var student1: [String] = ["짱구", "철수", "훈이"]
    var student2: [String] = ["짱아", "유리", "예슬"]
    
    // 학생들의 출석 여부
    var studentAttend1: [String: String?] = ["짱구": nil, "철수": nil, "훈이": nil]
    var studentAttend2: [String: String?] = ["짱아": nil, "유리": nil, "예슬": nil]
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onEdit(_ sender: UIButton) {
        if table.isEditing {
            sender.setTitle("편집", for: .normal)
            table.setEditing(false, animated: true)
        } else {
            sender.setTitle("확인", for: .normal)
            table.setEditing(true, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "남자아이"
        } else {
            return "여자아이"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) { // 첫 번째 섹션
            return student1.count
        } else { // 그 외의 섹션
            return student2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        //cell.label.text = String(indexPath.row) // 셀의 레이블에 텍스트 출력
        //cell.button.setTitle(String(indexPath.row), for: .normal) // 버튼의 텍스트 수정
        
        cell.delegate = self
        
        if(indexPath.section == 0) {
            cell.label.text = student1[indexPath.row]
            cell.index = indexPath.row
            cell.section = indexPath.section
        } else {
            cell.label.text = student2[indexPath.row]
            cell.index = indexPath.row
            cell.section = indexPath.section
        }
        
        return cell
    }
    
    // 삭제 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 학생 배열에서 삭제
            if(indexPath.section == 0) {
                student1.remove(at: indexPath.row)
            } else {
                student2.remove(at: indexPath.row)
            }
            // 테이블 뷰에서 삭제
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // 슬라이드시 뜨는 문구
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    // cell 순서 변경될 때 호출
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        if fromIndexPath.section == 0 { // 남자아이 섹션
            let movedStudent = student1[fromIndexPath.row]
            student1.remove(at: fromIndexPath.row)
            student1.insert(movedStudent, at: to.row)
        } else { // 여자아이 섹션
            let movedStudent = student2[fromIndexPath.row]
            student2.remove(at: fromIndexPath.row)
            student2.insert(movedStudent, at: to.row)
        }
        
        print(student1)
        print(student2)
    }

}

extension ViewController: TableViewCellDelegate {
    func didTapButton(cellSection: Int?, cellIndex: Int?, name: String?, button: UIButton?) {
        if(cellSection == 0) {
            if(name == studentAttend1["이름"]) {
                
            }
            
            button?.setTitle("결석", for: .normal)
        } else {
            
        }
    }
}
