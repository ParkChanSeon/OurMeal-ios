
import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var main_store_image: AnimatedImageView!
    
    @IBOutlet weak var main_store_title: UILabel!
    
    @IBOutlet weak var main_store_address: UILabel!
    
    @IBOutlet weak var main_store_score: UILabel!
    
    var main_store_code: String?
}
