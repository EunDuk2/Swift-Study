//
//  ViewController.swift
//  TabBar
//
//  Created by EUNSUNG on 2023/07/06.
//

import UIKit

class ViewController: UIViewController {
    
    var tabBar: UITabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let tabBarController = self.tabBarController else {
            return
        }
        tabBar = tabBarController.tabBar
        makeButton()
    }

    func makeButton() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 151, y: -50, width: 91, height: 91)
        button.setImage(UIImage(named: "icon_plus.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        if let tabBar = self.tabBarController?.tabBar {
            tabBar.addSubview(button)
        }
    }
    
    @objc func buttonTapped() {
        print("touch")
    }
}

