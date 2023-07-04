import UIKit
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var phone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onContact(_ sender: Any) {
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.delegate = self
        self.present(contactPickerViewController, animated: true, completion: nil)
    }
    
    // 연락처를 선택했을 때 발동
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // 이름 출력
        name.text = contact.familyName + " " + contact.givenName // (성 + 이름)
        
        // 저장된 전화번호 중에 첫 번째를 출력
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            phone.text = phoneNumber
        } else {
            phone.text = "No phone number available"
        }
        
    }
}

