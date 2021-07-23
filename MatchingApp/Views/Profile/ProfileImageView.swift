import UIKit

class ProfileImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        self.image = UIImage(named: "profile-selected")
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = 90
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
