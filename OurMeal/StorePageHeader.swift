

import UIKit

class StorePageHeader: UICollectionReusableView {
    
    
   
    
    @IBOutlet var header_image_scrollView: UIScrollView!
    @IBOutlet var store_score_label: UILabel!
    
    
    @IBOutlet var store_title_label: UILabel!
    @IBOutlet var store_address_label: UILabel!
    @IBOutlet var store_review_count_label: UILabel!
    @IBOutlet var store_big_review_count_label: UILabel!
   
    @IBOutlet var store_map_webView: UIWebView!
    
    
    var menuList : Array<Food_menu> = Array()
    var store_code: String?
    
}
