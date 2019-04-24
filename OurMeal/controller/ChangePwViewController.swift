

import UIKit

class ChangePwViewController: UIViewController {

    
   
    
    @IBOutlet var pw_text: UITextField!
    
    @IBOutlet var new_pw_text: UITextField!
    
    @IBOutlet var new_pw_text2: UITextField!
    
    @IBOutlet var pw_error_label: UILabel!
    
    
    @IBOutlet var new_pw_error_label: UILabel!
    @IBOutlet var new_pw_error_label2: UILabel!
    
   
    
    
    
    @IBAction func pw_text_editing_did_end(_ sender: Any) {
        // 현재 비밀번호 검사
        if pw_text.text! != UserDefaults.standard.string(forKey: "member_pw")!{
            pw_error_label.text = "현재 비밀번호와 일치하지 않습니다!"
        }
        
    
    
    
    
    }
    
    
    // 취소버튼 터치
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
    
    @IBAction func pw_text_editing_did_begin(_ sender: Any) {
        // 현재 비밀번호 검사시 에러라벨 값 초기화
        pw_error_label.text = ""
    }
    
    
    
    @IBAction func new_pw_text_editing_did_begin(_ sender: Any) {
        new_pw_error_label.text = ""
    }
    @IBAction func new_pw_text_editing_did_end(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "member_pw")! == new_pw_text.text!{
        new_pw_error_label.text = "기존의 비밀번호와 다른 비밀번호를 입력하세요!"
        }
        
        
    }
    
    
    @IBAction func new_pw_text2_editing_did_end(_ sender: Any) {
        if new_pw_text.text! != new_pw_text2.text! {
            new_pw_error_label2.text = "새로운 비밀번호가 일치하지 않습니다!"
        }
        if UserDefaults.standard.string(forKey: "member_pw")! == new_pw_text2.text!{
            new_pw_error_label2.text = "기존의 비밀번호와 다른 비밀번호를 입력하세요!"
        }
    }
    
    
    @IBAction func new_pw_text2_editing_did_begin(_ sender: Any) {
        new_pw_error_label2.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submit_btn_clicked(_ sender: Any) {
        
        if pw_text.text!.count == 0 {
            pw_error_label.text = "현재 비밀번호를 입력하세요!"
        }
        else if new_pw_text.text!.count == 0 {
            new_pw_error_label.text = "새로운 비밀번호를 입력하세요!"
        }
        else if new_pw_text2.text!.count == 0 {
            new_pw_error_label2.text = "새로운 비밀번호 확인을 입력하세요! "
        }
        else if new_pw_text2.text! != new_pw_text.text! {
            new_pw_error_label2.text = "새로운 비밀번호가 일치하지 않습니다."
        }
        else if pw_text.text! != UserDefaults.standard.string(forKey: "member_pw")! {
            pw_error_label.text = "현재 비밀번호와 일치하지 않습니다!"
        }
        else if UserDefaults.standard.string(forKey: "member_pw")! == new_pw_text.text! {
             new_pw_error_label.text = "기존의 비밀번호와 다른 비밀번호를 입력하세요!"
        }
        else if UserDefaults.standard.string(forKey: "member_pw")! == new_pw_text2.text! {
             new_pw_error_label2.text = "기존의 비밀번호와 다른 비밀번호를 입력하세요!"
        }
        
        else {
            
            let defaultSession = URLSession(configuration: .default)
            
            var dataTask: URLSessionDataTask?
            
            let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/ios_password_update")
            
            
            guard let url = urlComponents?.url else {return}
            
            // POST 방식의 요청을 처리하기 위한 URLRequest 객체 생성
            var request = URLRequest(url: url)
            // 요청 방식 설정
            request.httpMethod = "POST"
            // 요청 데이터 설정
            
            
            let body = "id=\(UserDefaults.standard.string(forKey: "member_id")!)&pw=\(pw_text.text!)&new_pw=\(new_pw_text2.text!)".data(using:String.Encoding.utf8)
            request.httpBody = body
            
            dataTask = defaultSession.dataTask(with: request){ data, response, error in
                
                if let error = error {
                    NSLog("통신 에러 발생")
                    NSLog("에러 메세지 : " + error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse,
                    response.statusCode == 200{
                    
                    NSLog(String( data: data, encoding: .utf8)!)
                    
                    class Change_pw : Codable{
                    var result : String?
                    }
                    
//                    var change_pw = Change_pw()
//
//
//                    change_pw = try! JSONDecoder().decode(Change_pw.self, from: data)
//
                    
                    
                    DispatchQueue.main.async {
                        
                     
                            
                            UserDefaults.standard.set(self.new_pw_text2.text!, forKey: "member_pw")
                            
                            let alert = UIAlertController(title: "비밀번호 변경 완료", message: "비밀번호가 변경 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                            let defaultAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.destructive) { (action) in
                                
                              //  self.navigationController?.popViewController(animated: true)
                                
                                
                                
//                                let storyboard: UIStoryboard = self.storyboard!
//                                let nextView = storyboard.instantiateViewController(withIdentifier: "loginSuccess")
//                                let navi = UINavigationController(rootViewController: nextView)
//                                navi.modalTransitionStyle = .coverVertical
//
//                                self.present(navi, animated: true, completion: nil)
                                
                                
                                let storyboard: UIStoryboard = self.storyboard!
                                let nextView = storyboard.instantiateViewController(withIdentifier: "loginSuccess")
                               
//                                let navi = UINavigationController(rootViewController: nextView)
//                                navi.modalTransitionStyle = .coverVertical

                                self.present(nextView, animated: true, completion: nil)
                                
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
