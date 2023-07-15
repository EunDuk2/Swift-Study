//
//  ViewController.swift
//  TableSearch
//
//  Created by EUNSUNG on 2023/07/15.
//

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
    var searchMode:Bool = false
    var currentText: String = ""
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textField.delegate = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func searchedCount() -> Int {
        var count:Int = 0
        
        for i in 0..<uni.count {
            if(searchedIndex(text: currentText, uniIndex: i)) {
                count += 1
            }
        }
        
        return count
    }
    
    func searchedIndex(text:String, uniIndex:Int) -> Bool {
        let universityName = uni[uniIndex]
        
        return universityName.hasPrefix(text)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchMode == true) {
            return searchedCount()
        } else {
            return uni.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        if(searchMode == true) {
            if(searchedIndex(text: currentText, uniIndex: indexPath.row)) {
                cell.label.text = uni[indexPath.row]
            }
        } else {
            cell.label.text = uni[indexPath.row]
        }
        
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 변경된 텍스트를 감지
        currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if currentText.isEmpty {
            searchMode = false
        } else {
            searchMode = true
        }
        
        // 텍스트가 변경될 때마다 테이블 뷰를 리로드하여 검색 모드를 반영합니다.
        table.reloadData()
        
        return true
    }
}

