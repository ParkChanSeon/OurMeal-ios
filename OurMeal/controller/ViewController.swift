import UIKit
import Kingfisher

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var mainNavi: UINavigationItem!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var loginMember : Member?
    
    var mainScore : Array<MainView> = Array()
    var mainBulletin : Array<MainView> = Array()
    var mainNewest : Array<MainView> = Array()
    var mainList : Array<MainView> = Array()
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return mainScore.count
        } else if section == 1 {
            return mainBulletin.count
        } else {
            return mainNewest.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell : MainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "list_cell", for: indexPath) as! MainCollectionViewCell
           var imgPath = "/resources/store/icon/noImage.jpeg"
            if let path = mainScore[indexPath.row].store_image{
            imgPath = path
            }
          
            cell.main_store_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath))
            cell.main_store_title.text = mainScore[indexPath.row].store_title
            cell.main_store_address.text = mainScore[indexPath.row].store_address
            let c:String = String(format:"%.1f", mainScore[indexPath.row].avg_score ?? 0.0)
            cell.main_store_score.text = c
            cell.main_store_code = mainScore[indexPath.row].store_code!
            return cell
        } else if indexPath.section == 1 {
            let cell : MainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "list_cell", for: indexPath) as! MainCollectionViewCell
            
            
                var imgPath = "/resources/store/icon/noImage.jpeg"
            if let path = mainBulletin[indexPath.row].store_image{
            imgPath = path
        }
            
            cell.main_store_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath))
            cell.main_store_title.text = mainBulletin[indexPath.row].store_title
            cell.main_store_address.text = mainBulletin[indexPath.row].store_address
            let c:String = String(format:"%.1f", mainBulletin[indexPath.row].avg_score  ?? 0.0)
            cell.main_store_score.text = c
            cell.main_store_code = mainBulletin[indexPath.row].store_code!
            
            return cell
        } else {
            let cell : MainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "list_cell", for: indexPath) as! MainCollectionViewCell
            
           
               var imgPath :String?
               imgPath = mainNewest[indexPath.row].store_image!
                
            cell.main_store_image.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
            cell.main_store_title.text = mainNewest[indexPath.row].store_title
            cell.main_store_address.text = mainNewest[indexPath.row].store_address
            let c:String = String(format:"%.1f", mainNewest[indexPath.row].avg_score ?? 0.0)
            cell.main_store_score.text = c
            cell.main_store_code = mainNewest[indexPath.row].store_code!
           
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        var header : MainCollectionViewHeader?
        
        if kind == UICollectionView.elementKindSectionHeader{
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headercell", for: indexPath)as? MainCollectionViewHeader
            
            // indexPath의 section을 가지고 구분
            if indexPath.section == 0{
                header?.main_collection_header.text = "Our Meal 평점이 높은 식당"
            } else if indexPath.section == 1{
                header?.main_collection_header.text = "Our Meal 관심이 많은 식당"
            } else if indexPath.section == 2{
                header?.main_collection_header.text = "Our Meal 신규 식당"
            }

        }
        
        return header!
    }
    
    
    
    class DataMap : Codable{
        var mainScore : Array<MainView> = Array()
        var mainBulletin : Array<MainView> = Array()
        var mainNewest : Array<MainView> = Array()
        // var mainList : Array<MainView> = Array()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: -50, y: -20, width: 2, height: 1))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo_ourmeal.png")
        imageView.image = image
        mainNavi.titleView = imageView
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        let urlComponents = URLComponents(string: "http://localhost:8080/OurMeal/m_main")
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
                self.mainScore = (dataMap?.mainScore)!
                self.mainBulletin = (dataMap?.mainBulletin)!
                self.mainNewest = (dataMap?.mainNewest)!
               DispatchQueue.main.async {
                   self.mainCollectionView.reloadData()
                    let collectionViewLayout = self.mainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
                    
                    collectionViewLayout?.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                    collectionViewLayout?.invalidateLayout()
                    }
            }
        }
        dataTask?.resume()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storePage"{
            let dest : StorePageCollectionViewController = segue.destination as! StorePageCollectionViewController
            let source: MainCollectionViewCell = sender as! UICollectionViewCell as! MainCollectionViewCell
            
            dest.store_title = source.main_store_title.text!
            dest.store_code = source.main_store_code
            
        }
    }
    
    
}
