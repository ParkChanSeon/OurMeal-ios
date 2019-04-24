

import UIKit
import Kingfisher

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var menuList : Array<Food_menu> = Array()
    var store_code: String?
    
    @IBOutlet var navi: UINavigationItem!
    
    @IBOutlet var menu_table_view: UITableView!
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("menuList.count : \(menuList.count)")
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        let index: Int = indexPath.row
        
        var imgPath :String?
        imgPath = menuList[index].fm_image
        cell.menu_image_view.kf.setImage(with:URL(string: "http://localhost:8080/OurMeal"+imgPath!))
        
        
        cell.menu_name_label.text = menuList[index].fm_name
        cell.menu_price_label.text = "가격 : \(String(describing: menuList[index].fm_price!))원"
        cell.menu_allergy_label.text = "알레르기 : \(String(describing: menuList[index].fm_allergy!))"
        cell.menu_info_label.text = "메뉴정보 : \n\(String(describing: menuList[index].fm_info!))"
        
        
        return cell
        
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: -50, y: -20, width: 2, height: 1))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo_ourmeal.png")
        imageView.image = image
        navi.titleView = imageView
       menu_table_view.reloadData()
        
    }
    

    

}
