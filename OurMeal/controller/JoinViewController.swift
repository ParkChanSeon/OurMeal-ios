

import UIKit

class JoinViewController: UIViewController {

    var msg : String?
    var result_code : String?
    var gender = String("남")
    @IBOutlet var id_text: UITextField!
    
    @IBOutlet var password_text: UITextField!
    
    @IBOutlet var password_text2: UITextField!
    
    @IBOutlet var error_id_label: UILabel!
    @IBOutlet var name_text: UITextField!
    
    @IBOutlet var birth_text: UITextField!
    
    @IBOutlet var name_error_label: UILabel!
    
    @IBOutlet var pw_error_label: UILabel!
    @IBOutlet var birth_error_label: UILabel!
    
    @IBOutlet var tel_error_label: UILabel!
    @IBOutlet var address_error_label: UILabel!
    
    @IBOutlet var email_error_label: UILabel!
    @IBOutlet var tel_text: UITextField!
    
    @IBOutlet var email_text: UITextField!
    
    @IBOutlet var gender_segement: UISegmentedControl!
    
   
    @IBAction func checked_id(_ sender: Any) {
        
        if id_text.text!.count == 0 {
            error_id_label.text = "아이디를 입력하세요"
        } else {
        
        let defaultSession = URLSession(configuration: .default)
        
        var dataTask: URLSessionDataTask?
        
        let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/checkId")
        
        guard let url = urlComponents?.url else {return}
        
        // POST 방식의 요청을 처리하기 위한 URLRequest 객체 생성
        var request = URLRequest(url: url)
        // 요청 방식 설정
        request.httpMethod = "POST"
        // 요청 데이터 설정
        let body = "joinReq_id=\(id_text.text!)".data(using:String.Encoding.utf8)
            request.httpBody = body
     
            dataTask = defaultSession.dataTask(with: request){ data, response, error in
            
            if let error = error {
                NSLog("통신 에러 발생")
                NSLog("에러 메세지 : " + error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                
                var check_id_map : Check_id_map?
                    
                 check_id_map = try! JSONDecoder().decode(Check_id_map.self, from: data)
                
                self.msg = (check_id_map?.msg)!
                self.result_code = (check_id_map?.result_code)!
                
                DispatchQueue.main.async {
                    
                    if self.result_code! == "1" {
                        self.error_id_label.textColor = UIColor.red
                        self.error_id_label.text = self.msg!
                    } else {
                       
                        self.error_id_label.textColor = UIColor.blue
                        self.error_id_label.text = self.msg!
                     }
                 }
            }
        }
        dataTask?.resume()
        
        }
     }
    
    
    
    
    
    @IBAction func submit_btn_clicked(_ sender: Any) {
        
        if id_text.text!.count == 0 {
            NSLog("아이디")
            error_id_label.text = "아이디를 입력하세요"
        } else if password_text.text!.count == 0 || password_text2.text!.count == 0 {
             NSLog("비번1")
            pw_error_label.text = "비밀번호를 입력하세요"
        } else if password_text2.text!.count == 0 || password_text2.text!.count == 0 {
            NSLog("비번2")
            pw_error_label.text = "비밀번호를 입력하세요"
        }else if name_text.text!.count == 0 {
             NSLog("이름")
            name_error_label.text = "이름을 입력하세요"
        } else if birth_text.text!.count == 0 {
             NSLog("생일")
            birth_error_label.text = "생년월일을 입력하세요"
        } else if tel_text.text!.count == 0 {
             NSLog("전화")
            tel_error_label.text = "전화번호를 입력하세요"
        } else if email_text.text!.count == 0 {
             NSLog("메일")
            email_error_label.text = "이메일을 입력하세요"
        } else if address_text.text!.count == 0 {
             NSLog("주소")
            address_error_label.text = "주소를 입력하세요"
        } else if password_text.text! != password_text2.text!{
             NSLog("비번 안일치")
            pw_error_label.text = "비밀번호가 일치하지 않습니다"
        }
        
        else {
            // 디비 인서트
            
            
            let defaultSession = URLSession(configuration: .default)
            
            var dataTask: URLSessionDataTask?
            
            let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/ios_join")
            
            
            guard let url = urlComponents?.url else {return}
            
            // POST 방식의 요청을 처리하기 위한 URLRequest 객체 생성
            var request = URLRequest(url: url)
            // 요청 방식 설정
            request.httpMethod = "POST"
            // 요청 데이터 설정
            
            
            let body = "id=\(id_text.text!)&pw=\(password_text2.text!)&name=\(name_text.text!)&birth=\(birth_text.text!)&sex=\(gender)&tel=\(tel_text.text!)&email=\(email_text.text!)&address=\(address_text.text!)".data(using:String.Encoding.utf8)
            request.httpBody = body
            
            dataTask = defaultSession.dataTask(with: request){ data, response, error in
                
                if let error = error {
                    NSLog("통신 에러 발생")
                    NSLog("에러 메세지 : " + error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse,
                    response.statusCode == 200{
                    
                    NSLog(String( data: data, encoding: .utf8)!)
                    
                    
                    var join_ok : Join_ok?
                    
                  join_ok = try! JSONDecoder().decode(Join_ok.self, from: data)
                    
                   
                    
                    DispatchQueue.main.async {
                        if join_ok!.join! {
                            
                            let alert = UIAlertController(title: "회원가입 완료", message: "회원가입이 완료되었습니다.", preferredStyle: UIAlertController.Style.alert)
                            let defaultAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.destructive) { (action) in
                                
                                let storyboard: UIStoryboard = self.storyboard!
                                let nextView = storyboard.instantiateViewController(withIdentifier: "login")
                                self.present(nextView, animated: true, completion: nil)
                            
                            }
                            alert.addAction(defaultAction)
                            
                            self.present(alert, animated: false, completion: nil)
                            
                          
                        }
                       
                        
                        
                    }
                }
            }
            dataTask?.resume()
           
            
           
            
            
            
            
          

        
        }    
    }
    
    
    @IBAction func name_editing(_ sender: Any) {
        name_error_label.text = ""
    }
   
    
    
    @IBAction func birth_editing(_ sender: Any) {
        birth_error_label.text = ""
    }
    
    
    @IBAction func tel_editing(_ sender: Any) {
         tel_error_label.text = ""
    }
    
    @IBAction func email_editing(_ sender: Any) {
         email_error_label.text = ""
    }
    
   
    @IBAction func change_address(_ sender: Any) {
        
        address_error_label.text = ""
    }
    @IBAction func cheched_pw(_ sender: Any) {
        
        if password_text.text! != password_text2.text! {
            
           
            pw_error_label.text = "비밀번호가 일치하지 않습니다."
            
        } else {
            pw_error_label.text = ""
        }
        
    }
    @IBOutlet var address_text: UITextField!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
 }
    

    class Check_id_map : Codable {
        var msg : String?
        var result_code : String?
    }
    
    class Join_ok : Codable {
        var join : Bool?
    }
    
    
    @IBAction func cancle_btn_clicked(_ sender: Any) {
        
        
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "login")
        present(nextView, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func gender_change(_ sender: Any) {
        
        
        if gender_segement.selectedSegmentIndex   ==   0
        {
           gender = "남"
        }
        else
        {
            gender = "여"
        }
        
    }
    
    
    
}
