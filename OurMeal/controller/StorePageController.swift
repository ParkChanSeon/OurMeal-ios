import UIKit
import Kingfisher


class StorePageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
  
    
 
    
    @IBOutlet var header_collection_view: UICollectionView!
    
    
   
    
    
    @IBOutlet var navi: UINavigationItem!
    
    @IBOutlet var store_title_label: UILabel!
    
    @IBOutlet var store_review_count_label: UILabel!
    @IBOutlet var store_address_label: UILabel!
    
    @IBOutlet var store_score_label: UILabel!
    
   
   
    
    var store_title: String?
    var store_code: String?
    
    var store : Store?
    var review_list : Array<Star_bulletin> = Array()
    var menuList : Array<Food_menu> = Array()
    var image_list : Array<Star_bulletin> = Array()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell : StorePageHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as! StorePageHeaderCell
        NSLog("헤더쎌에 이미지 넣기")
        var imgPath :String?
        imgPath = image_list[indexPath.row].sb_image!
        
        cell.header_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
        
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//        
//        if let daumTestMap = daumTestMap {
//            
//            daumTestMap.delegate = self as! MTMapViewDelegate
//            
//            daumTestMap.baseMapType = .standard
//            
//            self.view.addSubview(daumTestMap)
//            
//        }
        
        
        
        
        let imageView = UIImageView(frame: CGRect(x: -30, y: 0, width: 2, height: 1))
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
                
                
                DispatchQueue.main.async {
                   
                    self.header_collection_view.reloadData()
                    let collectionViewLayout = self.header_collection_view.collectionViewLayout as? UICollectionViewFlowLayout
                    
                    collectionViewLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    collectionViewLayout?.invalidateLayout()
                    
                    self.store_title_label.text = self.store!.store_title
                    
                    self.store_score_label.text = "\(String(describing: self.store!.score_avg ?? "0.0"))"
                    
                    
                    self.store_review_count_label.text = "\(String(describing: self.store!.store_reviewCount ?? 0))"
                    
                    self.store_address_label.text = "주소 : \(String(describing: self.store!.store_address ?? ""))"
                    
                    
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
    
    
   

}
