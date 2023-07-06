//
//  ViewController.swift
//  PickerView
//
//  Created by EUNSUNG on 2023/07/06.
//

import UIKit

class ViewController: UIViewController {
    let maxBank = 10 // 최대 은행 개수
    let pickerViewCnt = 1 // 피커뷰 열 1
    // 은행 목록
    var bankName = ["기업은행", "국민은행", "하나은행", "신한은행", "우리은행",
                    "산업은행", "농협", "새마을금고", "카카오뱅크", "케이뱅크"]
    
    @IBOutlet var pickerBank: UIPickerView!
    @IBOutlet var selectBank: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // 열
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewCnt
    }
    // 은행 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bankName.count
    }
    // 피커뷰에 각 은행 명칭을 넘김
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bankName[row]
    }
    // 선택한 은행을 레이블에 출력
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectBank.text = bankName[row]
    }
}
