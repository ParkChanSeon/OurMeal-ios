import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet var member_image: UIImageView!
    
    
    @IBOutlet var member_id_label: UILabel!
    @IBOutlet var score_image: UIImageView!
    
    @IBOutlet var review_content: UILabel!
    
    @IBOutlet var review_image: UIImageView!
    
    
    @IBOutlet var review_date_label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.review_image.image = nil
    }
}
