import UIKit

class CardInfoLabel: UILabel {
    
    //nooeとgoodのラベル
    init(frame: CGRect, labelText: String, labelColor: UIColor) {
        super.init(frame: frame)
        
        font = .boldSystemFont(ofSize: 45)
        text = labelText
        textColor = labelColor
        
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
        
    }
    
    //白文字のラベル
    init(frame: CGRect, labelText: String, labelfont: UIFont) {
        super.init(frame: frame)
        font = labelfont
        textColor = .white
        text = labelText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
