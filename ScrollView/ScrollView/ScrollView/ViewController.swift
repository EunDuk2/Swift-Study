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
        
    }


    @IBAction func onAdd(_ sender: Any) {
        label.text! += "안녕하세요"
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        showAlert()
    }

    
    func showAlert() {
        let alertController = UIAlertController(title: "알림", message: "알림창 예시", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            print("확인 버튼이 눌렸습니다.")
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (_) in
            print("취소 버튼이 눌렸습니다.")
        }
        alertController.addAction(cancelAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: <#bool#>, completion: nil)
    }
}

