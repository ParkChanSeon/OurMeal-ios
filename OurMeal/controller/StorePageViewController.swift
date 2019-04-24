
import UIKit
class StorePageViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet var big_review_count_label: UILabel!
    
    @IBOutlet var dmap: MTMapView!
    @IBOutlet var navi: UINavigationItem!
    
    @IBOutlet var review_collection_view: UICollectionView!
    @IBOutlet weak var header_collection_view: UICollectionView!
    @IBOutlet weak var store_title_label: UILabel!
    
    @IBOutlet weak var store_address_label: UILabel!
    
    @IBOutlet weak var store_review_count_label: UILabel!
    
    
    @IBOutlet weak var store_score_label: UILabel!
    
    var store_title: String?
    var store_code: String?
    
    var store : Store?
    var review_list : Array<Star_bulletin> = Array()
    var menuList : Array<Food_menu> = Array()
    var image_list : Array<Star_bulletin> = Array()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == header_collection_view{return image_list.count}
        else{
            
           NSLog("ㄹㅣ뷰셀 갯수 : \(review_list.count)")
            return review_list.count
        }
        
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == review_collection_view{
            
             NSLog("리뷰셀에 내용담기 시작")
            let cell2 : ReviewCollectionViewCell = review_collection_view.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
            
            var imgPath :String?
            imgPath = review_list[indexPath.row].sb_image!
            cell2.review_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
            imgPath = review_list[indexPath.row].member_image!
            cell2.member_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
            imgPath = review_list[indexPath.row].sb_score!
            
            if imgPath == "1.0"{
                let image1 = UIImage(named: "star_1.png")
                cell2.member_image = UIImageView(image:image1)
            }
            else if imgPath == "2.0"{
                 let image1 = UIImage(named: "star_2.png")
                cell2.member_image = UIImageView(image:image1)
            }
            else if imgPath == "3.0"{
                let image1 = UIImage(named: "star_3.png")
                cell2.member_image = UIImageView(image:image1)
            }
            else if imgPath == "4.0"{
                let image1 = UIImage(named: "star_4.png")
                cell2.member_image = UIImageView(image:image1)
            }
            else{
                 let image1 = UIImage(named: "star_5.png")
                cell2.member_image = UIImageView(image:image1)
            }
            
            cell2.member_id_label.text = review_list[indexPath.row].member_id
            cell2.review_content.text = review_list[indexPath.row].sb_content
            cell2.review_date_label.text = review_list[indexPath.row].sb_u_date
            NSLog("ㄹㅣ뷰쎌 데이터 완료")
            
            return cell2
            
            
            
            
            
            
        } else {
            
            let cell : StorePageHeaderImageCell = header_collection_view.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as! StorePageHeaderImageCell
            
            var imgPath :String?
            imgPath = image_list[indexPath.row].sb_image!
            
            cell.header_review_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
            
            return cell
            
        }
            
            
            
            
            
    }
    
//    func collectionView2(_ review_collection_view: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        NSLog("ㄹㅣ뷰셀 갯수 : \(review_list.count)")
//        return review_list.count
//    }
//
//    private func collectionView2(_ review_collection_view: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell : ReviewCollectionViewCell = review_collection_view.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
//
//        var imgPath :String?
//        imgPath = review_list[indexPath.row].sb_image!
//        cell.review_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
//        imgPath = review_list[indexPath.row].member_image!
//        cell.member_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
//        imgPath = review_list[indexPath.row].sb_score!
//
//        if imgPath == "1.0"{
//
//            cell.member_image = UIImageView(image:#imageLiteral(resourceName: "star_1.png"))
//        }
//         else if imgPath == "2.0"{
//            cell.member_image = UIImageView(image:#imageLiteral(resourceName: "star_2.png"))
//        }
//        else if imgPath == "3.0"{
//            cell.member_image = UIImageView(image:#imageLiteral(resourceName: "star_3.png"))
//        }
//        else if imgPath == "4.0"{
//            cell.member_image = UIImageView(image:#imageLiteral(resourceName: "star_4.png"))
//        }
//        else{
//            cell.member_image = UIImageView(image:#imageLiteral(resourceName: "star_5.png"))
//        }
//
//        cell.member_id_label.text = review_list[indexPath.row].member_id
//        cell.review_content.text = review_list[indexPath.row].sb_content
//       cell.review_date_label.text = review_list[indexPath.row].sb_u_date
//        NSLog("ㄹㅣ뷰쎌 데이터 완료")
//
//        return cell
//    }
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.dmap = MTMapView(frame: self.dmap.bounds)
//
//        if let dmap = self.dmap {
//
//            dmap.delegate = self as? MTMapViewDelegate
//
//            dmap.baseMapType = .standard
//            dmap.setZoomLevel(4, animated: true)
//
//
//            self.view.addSubview(dmap)
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
                    self.dmap.reloadInputViews()
                    self.header_collection_view.reloadData()
                    self.review_collection_view.reloadData()
                    
                    let collectionViewLayout = self.header_collection_view.collectionViewLayout as? UICollectionViewFlowLayout

                    collectionViewLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0.5, bottom: 0, right: 0)
                    collectionViewLayout?.invalidateLayout()
                    
                 
                    
                    
                    
                    
                    self.store_title_label.text = self.store!.store_title
                    
                    self.store_score_label.text = "\(String(describing: self.store!.score_avg ?? "0.0"))"
                    
                    
                    self.store_review_count_label.text = "\(String(describing: self.store!.store_reviewCount ?? 0))"
                    
                    self.store_address_label.text = "주소 : \(String(describing: self.store!.store_address ?? ""))"
                    
                    self.big_review_count_label.text = "주요 리뷰 (\(String(describing: self.store!.store_reviewCount ?? 0)))"
                    
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
