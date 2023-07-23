//
//  ViewController.swift
//  yanolja
//
//  Created by EUNSUNG on 2023/07/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeButton()
    }
    func makeButton() {
        let button = CustomButton(type: .custom)
        button.frame = CGRect(x: 167, y: -10, width: 60, height: 60)
        button.setBackgroundImage(UIImage(named: "ya.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        if let tabBar = self.tabBarController?.tabBar {
            tabBar.addSubview(button)
        }
    }

    @objc func buttonTapped() {
        print("touch")
    }

}

class CustomButton: UIButton {
    // 버튼을 터치할 때 이미지의 축소 비율
    private let shrinkScale: CGFloat = 0.8

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        // 버튼의 이미지가 터치되었을 때의 변화를 비활성화
        adjustsImageWhenHighlighted = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // 버튼 이미지 축소
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: self.shrinkScale, y: self.shrinkScale)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        // 버튼 이미지 원래 크기로 복구
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        // 버튼 이미지 원래 크기로 복구
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
}