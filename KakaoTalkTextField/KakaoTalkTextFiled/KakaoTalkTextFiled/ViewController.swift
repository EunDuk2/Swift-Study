//
//  ViewController.swift
//  KakaoTalkTextFiled
//
//  Created by EUNSUNG on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bottomBar: UIView!
    @IBOutlet var textBar: UIView!
    @IBOutlet var btn: UIButton!
    @IBOutlet var textView: UITextView!
    @IBOutlet var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSend.isHidden = true
        textView.delegate = self
        initTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 옵져버를 등록
        // 옵저버 대상 self
        // 옵져버 감지시 실행 함수
        // 옵져버가 감지할 것
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardUp(notification:NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keyboardRectangle = keyboardFrame.cgRectValue
       
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height + 30)
                }
            )
        }
    }
    
    @objc func keyboardDown() {
        self.view.transform = .identity
    }

    func initTextField() {
        textBar.layer.cornerRadius = 18
        textBar.layer.borderWidth = 1
        textBar.layer.borderColor = UIColor(red: 65/255, green: 66/255, blue: 66/255, alpha: 1).cgColor

    }

}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }

        // 텍스트 뷰의 contentSize를 기반으로 높이 조정
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: fixedWidth, height: newSize.height)
        textBar.frame.size.height = newSize.height
        bottomBar.frame.size.height = newSize.height

        if text.count > 0 {
            btn.isHidden = true
            btnSend.isHidden = false
        } else {
            btn.isHidden = false
            btnSend.isHidden = true
        }
        
        // 줄바꿈 횟수에 따라 스크롤 활성화/비활성화
        let numberOfLines = text.components(separatedBy: "\n").count
        let maxNumberOfLines = 4
        textView.isScrollEnabled = numberOfLines > maxNumberOfLines

        // 스크롤이 활성화되어 있을 경우 높이 제한
        if textView.isScrollEnabled {
            let maxHeight = textView.font!.lineHeight * CGFloat(maxNumberOfLines)
            textView.frame.size.height = min(newSize.height, maxHeight)
        }
    }
}




