import UIKit

class CardImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        layer.cornerRadius = 10
        contentMode = .scaleToFill
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
