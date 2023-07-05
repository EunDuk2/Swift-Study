import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onSend(_ sender: Any) {
        // 메시지 작성 가능한지 확인
        if MFMessageComposeViewController.canSendText() {
            let messageVC = MFMessageComposeViewController()
            
            // 메시지 내용 할당
            messageVC.body = "test"
            
            var phones: [String] = []
            
            // 보내려는 사람의 전화번호 추가
            phones.append("01012345678")
            phones.append("01012345566")
            
            // phones 배열을 messageVC의 recipients 속성에 할당하여 수신자 번호 설정
            messageVC.recipients = phones
            
            messageVC.messageComposeDelegate = self
            
            // MFMessageComposeViewController를 모달로 표시하여 메시지 작성 화면을 보여줌
            present(messageVC, animated: true, completion: nil)
        } else {
            print("메시지 전송 실패")
        }
    }
    
    // 메시지 작성이 완료되었을 때의 처리
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled: // 메시지 전송 취소
            print("Message cancelled")
        case .sent: // 메시지 전송 성공
            print("Message sent")
        case .failed: // 메시지 전송 실패
            print("Message sending failed")
        @unknown default:
            break
        }
        // 메시지 작성화면 종료
        controller.dismiss(animated: true, completion: nil)
    }
    
}

