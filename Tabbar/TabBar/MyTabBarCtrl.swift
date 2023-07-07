import UIKit

class MyTabBarCtrl: UITabBarController, UITabBarControllerDelegate {
    
    // UITabBarControllerDelegate를 요구하는 initializer를 추가합니다.
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 컨트롤러의 delegate를 self로 설정하여 MyTabBarCtrl이 UITabBarControllerDelegate 프로토콜을 처리할 수 있도록 합니다.
        self.delegate = self
    }
}
