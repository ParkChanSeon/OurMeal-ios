

import UIKit

class LoginViewController: UIViewController {

    
    var loginMember = Member()
    
    var msg : String = ""
    
    @IBOutlet var login_id: UITextField!
    
    @IBOutlet var login_password: UITextField!
    
    @IBOutlet var error_label: UILabel!
    
     let   defaultValues   =   UserDefaults.standard
    
    @IBAction func id_label_editing_change(_ sender: Any) {
        error_label.text=""
    }
    
    @IBAction func pw_label_editing_changed(_ sender: Any) {
        error_label.text=""
    }
    
    
      @IBAction func login_btn_clickded(_ sender: UIButton) {
        
        
        
        if login_id.text!.count == 0 {
            
            error_label.text="아이디를 입력하세요"
            
        } else if login_password.text!.count == 0 {
            
            error_label.text="비밀번호를 입력하세요"
            
        } else {
        
        let defaultSession = URLSession(configuration: .default)
        // URLSession 객체를 통해 통신을 처리할 수있는 TASK 변수 선언
           
        var dataTask: URLSessionDataTask?
        // URL 문자열을 기반으로 다양한 작업을 처리할 수 있는 객체 생성
        let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/m_login")
        
        
        guard let url = urlComponents?.url else {return}
        
        // POST 방식의 요청을 처리하기 위한 URLRequest 객체 생성
        var request = URLRequest(url: url)
        // 요청 방식 설정
        request.httpMethod = "POST"
        // 요청 데이터 설정
        
        NSLog("member_id=\(login_id.text!)&member_pw=\(login_password.text!)")
            let body = "member_id=\(login_id.text!)&member_pw=\(login_password.text!)".data(using:String.Encoding.utf8)
            request.httpBody = body
        
       
        
        
        dataTask = defaultSession.dataTask(with: request){ data, response, error in
            NSLog("접속해서")
            if let error = error {
                NSLog("통신 에러 발생")
                NSLog("에러 메세지 : " + error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                
                NSLog(String( data: data, encoding: .utf8)!)
                
                
                
                
                var loginDataMap : LoginDataMap?
                
              loginDataMap = try! JSONDecoder().decode(LoginDataMap.self, from: data)

                
                
                self.msg = (loginDataMap?.msg)!
                NSLog(self.msg)
               
                if let test = loginDataMap?.loginMember{
                self.loginMember = test
                  }
              
                
                if self.msg == "nodata" {
                  
                    
                    DispatchQueue.main.async {
                        
                        self.error_label.text = "로그인정보를 확인하세요"
                    }
                    
                    
                    
                } else {
                    
                    
                    
                    UserDefaults.standard.set(self.loginMember.member_id!, forKey: "member_id")
                    UserDefaults.standard.set(self.loginMember.member_pw!, forKey: "member_pw")
                    UserDefaults.standard.set(self.loginMember.member_name!, forKey: "member_name")
                    UserDefaults.standard.set(self.loginMember.member_birth!, forKey: "member_birth")
                    UserDefaults.standard.set(self.loginMember.member_image!, forKey: "member_image")
                    UserDefaults.standard.set(self.loginMember.member_phone!, forKey: "member_phone")
                    UserDefaults.standard.set(self.loginMember.member_email!, forKey: "member_email")
                    
                    if let addr = self.loginMember.member_address{
                    UserDefaults.standard.set(addr, forKey: "member_address")
                    }
                   
                    
                    DispatchQueue.main.async {
                       
                       
                        let storyboard: UIStoryboard = self.storyboard!
                        let nextView = storyboard.instantiateViewController(withIdentifier: "loginSuccess")
                        self.present(nextView, animated: true, completion: nil)
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
           
                
                
            }
        }
        dataTask?.resume()
        
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    class LoginDataMap : Codable{
        var msg : String
        var loginMember = Member()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "loginSuccess"{
            
            
            
           
        }
    
    }

}
