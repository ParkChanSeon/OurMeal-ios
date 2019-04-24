import UIKit
import Kingfisher
import Alamofire
import MobileCoreServices
class MyPageViewController: UIViewController, UIScrollViewDelegate{

    var loginMember : Member?
    
    @IBOutlet var mypage_label: UILabel!
    @IBOutlet var name_label: UILabel!
    @IBOutlet var mypage_scrollview: UIScrollView!
    @IBOutlet var email_label: UILabel!
    @IBOutlet var tel_label: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var address_label: UILabel!
    
   let picker = UIImagePickerController()
   
    
    
    @IBAction func logout_btn_clicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "로그아웃", style: UIAlertAction.Style.destructive){ (action) in
            
            UserDefaults.standard.removePersistentDomain ( forName :"com.javaking.OurMeal" )
            
            UserDefaults.standard.synchronize ( )
            
            NSLog("\(UserDefaults . standard.string(forKey: "member_id"))")
            
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "login")
            self.present(nextView, animated: true, completion: nil)
            
        }
         let defaultAction2 = UIAlertAction(title: "취소", style: UIAlertAction.Style.destructive, handler : nil)
        alert.addAction(defaultAction)
        alert.addAction(defaultAction2)
        
         self.present(alert, animated: false, completion: nil)
        
      }
    
    
    
    
    @IBAction func image_change_btn_clicked(_ sender: Any) {
        picker.sourceType = .photoLibrary
        
        present(picker, animated: false, completion: nil)
        
        
        
        
       
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        view_setting()
    }
    
    func view_setting() {
        mypage_label.text = "My Page(ID : \(UserDefaults.standard.string(forKey: "member_id")!))"
        name_label.text = "\(UserDefaults.standard.string(forKey: "member_name")!)"
        email_label.text = "\(UserDefaults.standard.string(forKey: "member_email")!)"
        tel_label.text = "\(UserDefaults.standard.string(forKey: "member_phone")!)"
        address_label.text = ""
        if let addr = UserDefaults.standard.string(forKey: "member_address") {
            address_label.text = addr
        }
        let imgPath = "\(UserDefaults.standard.string(forKey: "member_image")!)"
        
        imageView.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal/" + imgPath))
        imageView.layer.cornerRadius = 20.0;        //테두리가 라운드가 된다.
        imageView.layer.masksToBounds = true;
        
    }
    
    

}
extension MyPageViewController : UIImagePickerControllerDelegate,
    
UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            imageView.image = image
            
            let file = image.pngData()!
            
            NSLog("사진정보 : \(info)")
            
            
            Alamofire.upload( multipartFormData: { multipartFormData in multipartFormData.append(self.imageView.image!.pngData()!, withName: "file", fileName: "picture.png", mimeType: "image/png")
                // Send parameters
                multipartFormData.append((UserDefaults.standard.string(forKey: "member_id")as! String).data(using: .utf8)!, withName: "member_id")
            }, to: "http://localhost:8080/OurMeal/ios_profile_image_upload", encodingCompletion: { encodingResult in switch encodingResult { case .success(let upload, _, _): upload.responseJSON {
                
                response in debugPrint("SUCCESS RESPONSE: \(response)")
                
                var map :ImageChangeMap?
                
                
                
                
                } case .failure(let encodingError):  print("ERROR RESPONSE: \(encodingError)") } } )

          
            
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    
    
}


class ImageChangeMap : Codable{
    var member_imgage : String
    }
