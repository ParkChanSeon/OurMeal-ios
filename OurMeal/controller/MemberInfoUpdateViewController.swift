

import UIKit

class MemberInfoUpdateViewController: UIViewController {

    
    @IBOutlet var name_text: UITextField!
    
    @IBOutlet var name_error_label: UILabel!
    @IBOutlet var address_text: UITextField!
    
    @IBOutlet var birth_text: UITextField!
    
    @IBOutlet var birth_error_label: UILabel!
    @IBOutlet var email_text: UITextField!
    
    
    @IBOutlet var phone_text: UITextField!
    
    @IBOutlet var address_error_label: UILabel!
    
    @IBOutlet var email_error_label: UILabel!
    
    @IBOutlet var phone_error_label: UILabel!
    
    
    // 취소버튼 클릭시
    @IBAction func cancle_btn_touch(_ sender: Any) {
        
        let alert = UIAlertController(title: "취소", message: "취소하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.destructive){ (action) in
            
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "loginSuccess")
            
            self.present(nextView, animated: true, completion: nil)
            
        }
        let defaultAction2 = UIAlertAction(title: "취소", style: UIAlertAction.Style.destructive, handler : nil)
        alert.addAction(defaultAction)
        alert.addAction(defaultAction2)
        
        self.present(alert, animated: false, completion: nil)
        
        
    }
    
    @IBAction func name_editing_did_begin(_ sender: Any) {
        name_error_label.text = ""
    }
    
    @IBAction func birth_editing_did_begin(_ sender: Any) {
        birth_error_label.text = ""
    }
    
    @IBAction func address_editing_did_begin(_ sender: Any) {
        address_error_label.text = ""
    }
    
    
    @IBAction func email_editing_did_begin(_ sender: Any) {
        email_error_label.text = ""
    }
    
    
    @IBAction func phone_editing_did_begin(_ sender: Any) {
        phone_error_label.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = UserDefaults.standard.string(forKey: "member_name"){
            name_text.text = name
        }
        
        if let birth = UserDefaults.standard.string(forKey: "member_birth"){
            birth_text.text = birth
        }
        
        
        if let addr = UserDefaults.standard.string(forKey: "member_address"){
        address_text.text = addr
        }
        
        if let email = UserDefaults.standard.string(forKey: "member_email"){
            email_text.text = email
        }
        
        if let phone = UserDefaults.standard.string(forKey: "member_phone"){
            phone_text.text = phone
        }

     
    }
    

   
    @IBAction func submit_btn_clicked(_ sender: Any) {
       
        if  name_text.text!.count == 0 {
            name_error_label.text = "이름을 입력하세요!"
        }
        else if  birth_text.text!.count == 0 {
            birth_error_label.text = "생년월일을 입력하세요!"
        }else if  address_text.text!.count == 0 {
            address_error_label.text = "주소를 입력하세요!"
        } else if email_text.text!.count == 0 {
            email_error_label.text = "이메일을 입력하세요!"
        } else if phone_text.text!.count == 0 {
            phone_error_label.text = "연락처를 입력하세요!"
        
        } else {
            
            name_error_label.text = ""
            birth_error_label.text = ""
            address_error_label.text = ""
            email_error_label.text = ""
             phone_error_label.text = ""
            
            
            
            let defaultSession = URLSession(configuration: .default)
            
            var dataTask: URLSessionDataTask?
            
            let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/ios_profile_update")
            
            
            guard let url = urlComponents?.url else {return}
            
            // POST 방식의 요청을 처리하기 위한 URLRequest 객체 생성
            var request = URLRequest(url: url)
            // 요청 방식 설정
            request.httpMethod = "POST"
            // 요청 데이터 설정
            
            
            let body = "id=\(UserDefaults.standard.string(forKey: "member_id")!)&name=\(name_text.text!)&birth=\(birth_text.text!)&email=\(email_text.text!)&address=\(address_text.text!)&phone=\(phone_text.text!)".data(using:String.Encoding.utf8)
            request.httpBody = body
            
            dataTask = defaultSession.dataTask(with: request){ data, response, error in
                
                if let error = error {
                    NSLog("통신 에러 발생")
                    NSLog("에러 메세지 : " + error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse,
                    response.statusCode == 200{
                    
                    NSLog(String( data: data, encoding: .utf8)!)
                    
                     DispatchQueue.main.async {
                        
                       
                        
                        UserDefaults.standard.set(self.name_text.text!, forKey: "member_name")
                        UserDefaults.standard.set(self.birth_text.text!, forKey: "member_birth")
                       
                        UserDefaults.standard.set(self.phone_text.text!, forKey: "member_phone")
                        UserDefaults.standard.set(self.email_text.text!, forKey: "member_email")
                        UserDefaults.standard.set(self.address_text.text!, forKey: "member_address")
                            
                        let alert = UIAlertController(title: "회원정보 변경 완료", message: "회원정보가 변경 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                        let defaultAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.destructive) { (action) in
                          
                           
                            
                            self.navigationController?.popViewController(animated: true)
                            
                            
                            
                            let storyboard: UIStoryboard = self.storyboard!
                            let nextView = storyboard.instantiateViewController(withIdentifier: "loginSuccess")
//                            let navi = UINavigationController(rootViewController: nextView)
//                            navi.modalTransitionStyle = .coverVertical

                            self.present(nextView, animated: true, completion: nil)
                            
                            
                            //                                let storyboard: UIStoryboard = self.storyboard!
                            //                                let nextView = storyboard.instantiateViewController(withIdentifier: "mypage")
                            //                                let navi = UINavigationController(rootViewController: nextView)
                            //                                navi.modalTransitionStyle = .coverVertical
                            //
                            //                                self.present(navi, animated: true, completion: nil)
                            
                        }
                        alert.addAction(defaultAction)
                        
                        self.present(alert, animated: false, completion: nil)
                        
                        
                        
                            
                        
                        
                        
                        
                    }
                }
            }
            dataTask?.resume()
            
        }
        
        
        
    }
    
}
