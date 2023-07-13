//
//  ViewController.swift
//  KakaoTalkTextFiled
//
//  Created by EUNSUNG on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {
    
    var preLines: Int = 1
    var numberOfLines:Int = 1// 현재 라인 수
    
    @IBOutlet var bottomBar: UIView!
    @IBOutlet var textBar: UIView!
    @IBOutlet var btn: UIButton!
    @IBOutlet var textView: UITextView!
    @IBOutlet var btnSend: UIButton!
    @IBOutlet var table: UITableView!
    
    @IBOutlet var textBarHeight: NSLayoutConstraint!
    @IBOutlet var bottomBarHeight: NSLayoutConstraint!
    @IBOutlet var tableTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
        
        btnSend.isHidden = true
        textView.delegate = self
        initTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 키보드가 나타날 때의 알림에 대해 옵저버를 등록합니다.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드가 사라질 때의 알림에 대해 옵저버를 등록합니다.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        // 등록한 옵저버를 제거합니다.
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardUp(notification:NSNotification) {
        // 키보드 프레임 정보를 가져옵니다.
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            // 애니메이션을 사용하여 뷰의 변환을 수행합니다.
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height + 30)
                }
            )
        }
    }
    
    @objc func keyboardDown() {
        // 키보드가 사라질 때 뷰의 변환을 초기화합니다.
        self.view.transform = .identity
    }
    
    func navigationSetting() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 39/255, alpha: 1)
        navigationController!.navigationBar.standardAppearance = navigationBarAppearance
        navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.title = "은덕이"
    }

    func initTextField() {
        textBar.layer.cornerRadius = 18
        textBar.layer.borderWidth = 1
        textBar.layer.borderColor = UIColor(red: 65/255, green: 66/255, blue: 66/255, alpha: 1).cgColor

    }
    
    func numberOfLinesInTextView(textView: UITextView) -> Int {
        // 텍스트 뷰의 레이아웃 매니저를 가져옵니다.
        let layoutManager = textView.layoutManager
        
        // 전체 글리프의 수를 가져옵니다.
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        
        // 라인의 범위와 라인 번호를 초기화합니다.
        var lineRange = NSRange(location: 0, length: 0)
        var lineNumber = 0
        
        // 모든 글리프에 대해 반복합니다.
        for index in 0..<numberOfGlyphs {
            // 현재 글리프의 라인 프래그먼트 사각형과 해당 라인의 범위를 가져옵니다.
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            
            // 현재 인덱스가 라인의 시작 위치와 동일하다면 새로운 라인이 시작되었음을 의미하므로 lineNumber를 증가시킵니다.
            if lineRange.location == index {
                lineNumber += 1
            }
        }
        
        // 전체 라인 수를 반환합니다.
        return lineNumber
    }
    
    var text: [String]? = ["test"]
    
    @IBAction func onSend(_ sender: Any) {
        numberOfLines = 1
        bottomBarHeight.constant = 78
        textBarHeight.constant = 36
        
        text?.append(textView.text)
        
        textView.text = ""
        btn.isHidden = false
        btnSend.isHidden = true
        
        tableTop.constant -= 45
        if(tableTop.constant < 0) {
            tableTop.constant = 0
        }
        
        table.reloadData()
    }

}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
        // + (text.components(separatedBy: "\n").count - 1)
        numberOfLines = numberOfLinesInTextView(textView: textView) // 현재 라인 수
        
        // preLines는 한 번의 액션 전의 라인 수

        let num:CGFloat = 15
        if(numberOfLines <= 0) {
            numberOfLines = 1
        }
        
        // 현재 라인 수가 전의 라인 수와 다를 경우에 높이 변경
        if(numberOfLines != preLines) {
            if(numberOfLines > preLines && numberOfLines <= 4) { // 라인 수가 늘어났을 때 // 높이 변경은 최대 4칸까지
                bottomBar.frame.origin.y -= num // 하단 뷰의 위치 변경
                bottomBarHeight.constant += num // 하단 뷰의 오토레이아웃 높이 변경
                
                textBarHeight.constant += num // 텍스트 뷰를 품고 있는 뷰의 오토레이아웃 높이 변경
            } else if(numberOfLines < preLines && numberOfLines < 4) { // 라인 수가 줄어들었을 때
                bottomBar.frame.origin.y += num
                bottomBarHeight.constant -= num
                
                textBarHeight.constant -= num
            }

        }
                
        preLines = numberOfLines
        
        // 전송버튼 여부
        if text.count > 0 {
            btn.isHidden = true
            btnSend.isHidden = false
        } else {
            btn.isHidden = false
            btnSend.isHidden = true
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let txtCount: Int = text?.count {
            return txtCount
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        if let tmpText = text {
            cell.lblText.text = tmpText[indexPath.row]
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"

            let currentTime = Date()
            let currentTimeString = dateFormatter.string(from: currentTime)
            
            cell.lblTime.text = currentTimeString
            
        }
        
        return cell
    }
}

