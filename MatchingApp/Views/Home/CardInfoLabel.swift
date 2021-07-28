import UIKit

class CardInfoLabel: UILabel {
    
    //nooeとgoodのラベル
    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 45)
        self.text = text
        self.textColor = textColor
        
        layer.borderWidth = 3
        layer.borderColor = textColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
        
    }
    
    //白文字のラベル
    init (font: UIFont) {
        super.init(frame: .zero)
        self.font = font
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
