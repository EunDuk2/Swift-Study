import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet var showPicker: UITextField!
    
    let fruits = ["사과", "배", "포도", "망고", "딸기", "바나나", "파인애플"]
    var index: Int?
    
    override func viewDidLoad() {
        showPicker.tintColor = .clear
        createPickerView()
        dismissPickerView()
    }
}

extension ViewController2: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruits.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fruits[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    // 포커스를 해제해줌. 피커뷰를 내려줌
    @objc func cancel() {
        showPicker.resignFirstResponder()
    }
    // 텍스트 필드에 출력하고 피커뷰 내림
    @objc func submit() {
        if let i = index {
            showPicker.text = fruits[i]
        } else {
            print("index오류")
        }
        showPicker.resignFirstResponder()
    }
    
    // 텍스트 필드 터치시 inputView가 뜨는데 피커뷰 인스턴스를 연결
    // 한마디로 텍스트 필드 터치시 과일배열 담고 있는 피커뷰 올라옴
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        showPicker.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancel))
        let submitButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(self.submit))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, flexibleSpace, submitButton], animated: true)
        toolBar.isUserInteractionEnabled = true // true로 해줘야 툴바의 버튼 사용 가능
        showPicker.inputAccessoryView = toolBar // 텍스트필드 터치시 툴바 표시
    }
}
