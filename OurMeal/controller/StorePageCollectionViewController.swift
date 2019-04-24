
import UIKit



class StorePageCollectionViewController: UICollectionViewController, UIWebViewDelegate, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet var storePageCollectionView: UICollectionView!
    @IBOutlet var navi: UINavigationItem!
    
   
    
    
    var num = Int(5)
    var store_title: String?
    var store_code: String?
    
    var store : Store?
    var review_list : Array<Star_bulletin> = Array()
    
    var review_size_list : Array<Int> = Array()
    
    var menuList : Array<Food_menu> = Array()
    var image_list : Array<Star_bulletin> = Array()
    var append_review : String?
    
    var x = Int(0)
    var y = Int(0)
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cell_height = Int(380)

         NSLog("높이지정")
        NSLog("\(review_list[indexPath.row].sb_content!.count)")

        if review_list[indexPath.row].sb_image!.count == 0 {
            NSLog("이미지 포함안함")
            cell_height -= 200
        }


        

            var i = review_list[indexPath.row].sb_content!.count
            let j = 20

            repeat {
                i -= j
                cell_height += 39
                NSLog("(\(i),\(j))")
                if i <= j {
                   break
                }
            } while (true)
        
        
        NSLog("높이지정 (\([indexPath.row])): \(cell_height)")
        
         
        return CGSize(width: 380, height: cell_height)

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

       return review_list.count;
   }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
       
        
        if kind == UICollectionView.elementKindSectionHeader{
             var header : StorePageHeader?
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "store_page_header", for: indexPath)as? StorePageHeader
           
           if indexPath.section == 0 {
            
            
            if let storeTest = store {
                
            header?.menuList = self.menuList
            header?.store_code = self.store_code
            header?.store_address_label.text = "주소 : \(String(describing: storeTest.store_address ?? ""))"
            
            header?.store_big_review_count_label.text = "주요 리뷰 (\(String(describing: storeTest.store_reviewCount ?? 0)))"
            
                
                
                if storeTest.score_avg == "NaN" {
                     header?.store_score_label.text = "0.0"
                } else {
            header?.store_score_label.text = storeTest.score_avg
                }
            header?.store_title_label.text = self.store_title!
            header?.store_review_count_label.text = "\(String(describing: storeTest.store_reviewCount ?? 0))"
              
                var i = Int(0)
               
               
                for _ in image_list{
                    
              
                var header_image = UIImageView(image: UIImage(named: "") )
                header_image.frame = CGRect(x: self.x, y: self.y, width: 134, height: 128)
               x += 135
                var imgPath : String?
                imgPath = image_list[i].sb_image!
                
                header_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal/"+imgPath!))
                
                
                header?.header_image_scrollView.addSubview(header_image)
                i+=1
                   
                }
            
                
                
            }
            
           
                
                let address = "http://localhost:8080/OurMeal/store_map?store_code=\(String(describing: store_code!))"
                let url = URL(string: address)
            
                if let mapURL = url {
                    
                    let request = URLRequest(url: mapURL)
                    
                    header?.store_map_webView.loadRequest(request)
                
            }
            
            
            
            
          
            
        }
         return header!
        }
       else {
            
            var footer : StorePageAddReviewReusableView?
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "addReview", for: indexPath)as? StorePageAddReviewReusableView
           
            if indexPath.section == 0 {
                 if let storeTest = store {
                    
                    if storeTest.store_reviewCount! < 6 {
                    footer?.addReview_btn.removeFromSuperview()
                } else {
                
               
           footer?.addReview_btn.setTitle("더보기(\(review_list.count)/\(String(describing: storeTest.store_reviewCount ?? 0)))", for: .normal)
                        if let testAppend = append_review {
                        let strInt = Int(testAppend)
                    if strInt! >= storeTest.store_reviewCount!{
                        footer?.addReview_btn.removeFromSuperview()
                        }
                        }
                    
                    }
                }
            }
           return footer!
        }
        
       
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
    
   
    var cell : ReviewCollectionViewCell = storePageCollectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
if indexPath.section == 0 {
   var imgPath :String?
    
    if review_list[indexPath.row].sb_image!.count != 0 {

        
        imgPath = review_list[indexPath.row].sb_image!
        cell.review_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))


    } else {
        cell.review_image.frame = CGRect(x: 0, y: 0, width: 0, height: 0)


    }
    
    
    
    
            imgPath = review_list[indexPath.row].member_image!
            cell.member_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
            imgPath = review_list[indexPath.row].sb_score!
    
    

   
            if imgPath! == "1.0"{
               cell.score_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal/resources/store/icon/star_1.png"))
            }
            else if imgPath! == "2.0"{
               cell.score_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal/resources/store/icon/star_2.png"))
            }
            else if imgPath! == "3.0"{
                cell.score_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal/resources/store/icon/star_3.png"))
            }
            else if imgPath! == "4.0"{
                cell.score_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal/resources/store/icon/star_4.png"))
            }
            else{
               cell.score_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal/resources/store/icon/star_5.png"))
            }

            cell.member_id_label.text = review_list[indexPath.row].member_id
            cell.review_content.text = review_list[indexPath.row].sb_content
            cell.review_date_label.text = review_list[indexPath.row].sb_u_date
    
        }

            return cell
    
 }

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        

        let imageView = UIImageView(frame: CGRect(x: -50, y: -20, width: 2, height: 1))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo_ourmeal.png")
        imageView.image = image
        navi.titleView = imageView
        
        
        
        let defaultSession = URLSession(configuration: .default)
        // URLSession 객체를 통해 통신을 처리할 수있는 TASK 변수 선언
        var dataTask: URLSessionDataTask?
        // URL 문자열을 기반으로 다양한 작업을 처리할 수 있는 객체 생성
        let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/m_storePage?store_code=\(store_code!)")
        
        
        guard let url = urlComponents?.url else {return}
        
        
        dataTask = defaultSession.dataTask(with: url){ data, response, error in
            
            if let error = error {
                NSLog("통신 에러 발생")
                NSLog("에러 메세지 : " + error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                
                NSLog(String( data: data, encoding: .utf8)!)
                
                
                
                
                var dataMap :DataMap?
                
                dataMap = try! JSONDecoder().decode(DataMap.self, from: data)
                self.store = (dataMap?.store)!
                self.review_list = (dataMap?.review_list)!
                self.menuList = (dataMap?.menuList)!
                self.image_list = (dataMap?.image_list)!
                
                var i = 0
                
                for _ in self.review_list{
                
                NSLog("리뷰 글 텍스트 카운트 : \(self.review_list[i].sb_content!.count)")
                    i += 1
                }
                
                DispatchQueue.main.async {
                    
                   
                    self.storePageCollectionView.reloadData()
                    
                    
                    
                    let collectionViewLayout = self.storePageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
                    
                    collectionViewLayout?.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
                    collectionViewLayout?.invalidateLayout()
                    
                    
                    
                    
                    
                    
           
                }
            }
        }
        dataTask?.resume()
        
       
    }
    
    class DataMap : Codable{
        var store : Store
        var review_list : Array<Star_bulletin> = Array()
        var menuList : Array<Food_menu> = Array()
        var image_list : Array<Star_bulletin> = Array()
        
    }
    
    class AddReview : Codable{
        var review_list : Array<Star_bulletin> = Array()
        var append_review : String
    }
    
    
    @IBAction func addReview_btn_clicked(_ sender: Any) {
        
         let defaultSession = URLSession(configuration: .default)
        // URLSession 객체를 통해 통신을 처리할 수있는 TASK 변수 선언
        var dataTask: URLSessionDataTask?
        // URL 문자열을 기반으로 다양한 작업을 처리할 수 있는 객체 생성
        let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/m_storePage/reviewAdd")
        
        
        guard let url = urlComponents?.url else {return}
        
        // POST 방식의 요청을 처리하기 위한 URLRequest 객체 생성
        var request = URLRequest(url: url)
        // 요청 방식 설정
        request.httpMethod = "POST"
        // 요청 데이터 설정
        
        if let storeTest = store {
        let body = "num=\(num)&store_code=\(storeTest.store_code!)".data(using:String.Encoding.utf8)
        request.httpBody = body
            num += 5
        }
        
        
        dataTask = defaultSession.dataTask(with: request){ data, response, error in
            
            if let error = error {
                NSLog("통신 에러 발생")
                NSLog("에러 메세지 : " + error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                
                NSLog(String( data: data, encoding: .utf8)!)
                
                
                
                
                var dataMap :AddReview?
                
                dataMap = try! JSONDecoder().decode(AddReview.self, from: data)
                
                self.review_list = (dataMap?.review_list)!
                self.append_review = (dataMap?.append_review)!
                
                
               
                DispatchQueue.main.async {
                    
                    
                    self.storePageCollectionView.reloadData()
                    
                    
                    
                    let collectionViewLayout = self.storePageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
                    
                    collectionViewLayout?.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
                    
                    collectionViewLayout?.invalidateLayout()
                    
                    
                    
                   
                    
                    
                }
            }
        }
        dataTask?.resume()
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menu"{
            let dest : MenuViewController = segue.destination as! MenuViewController
           
            dest.menuList = menuList
            dest.store_code = store_code
            
        }
    }
    
    

}
