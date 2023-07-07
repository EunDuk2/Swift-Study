import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 사진 촬영 액션
        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.openCamera()
        }
        
        // 앨범에서 가져오기 액션
        let choosePhotoAction = UIAlertAction(title: "앨범에서 가져오기", style: .default) { _ in
            self.openPhotoLibrary()
        }
        
        // 취소 액션
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        // 액션 추가
        alertController.addAction(takePhotoAction)
        alertController.addAction(choosePhotoAction)
        alertController.addAction(cancelAction)
        
        // 액션 시트 표시
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func addImage(_ sender: Any) {
        showActionSheet()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 카메라 열기
    func openCamera() {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera // 카메라
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("카메라를 사용할 수 없습니다.")
        }
    }
    
    // 앨범 열기
    func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary // 앨범
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("앨범에 접근할 수 없습니다.")
        }
    }
    
    // 사진 선택 완료 시 호출되는 delegate 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 사진 선택 취소 시 호출되는 delegate 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
