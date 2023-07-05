//
//  ViewController.swift
//  Share
//
//  Created by EUNSUNG on 2023/07/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onShare(_ sender: Any) {
        var shareItems = [Any]()
        
        // 공유할 텍스트를 shareItems 배열에 추가
        shareItems.append("test")
        // 공유할 사진을 shareItems 배열에 추가
        shareItems.append(UIImage(named: "flower.png"))
        
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

