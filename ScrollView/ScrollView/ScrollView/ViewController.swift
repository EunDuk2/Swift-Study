//
//  ViewController.swift
//  ScrollView
//
//  Created by EUNSUNG on 2023/07/14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showAlert()
    }


    @IBAction func onAdd(_ sender: Any) {
        label.text! += "안녕하세요"
    }
    
    func showAlert() {
        // 1. UIAlertController 인스턴스 생성
        let alertController = UIAlertController(title: "알림", message: "이것은 Alert 예제입니다.", preferredStyle: .alert)
        
        // 2. 확인 버튼 추가
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            // 확인 버튼을 눌렀을 때 처리할 내용을 여기에 작성합니다.
            print("확인 버튼이 눌렸습니다.")
        }
        alertController.addAction(okAction)
        
        // 3. 취소 버튼 추가
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (_) in
            // 취소 버튼을 눌렀을 때 처리할 내용을 여기에 작성합니다.
            print("취소 버튼이 눌렸습니다.")
        }
        alertController.addAction(cancelAction)
        
        // 4. Alert를 화면에 표시
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

