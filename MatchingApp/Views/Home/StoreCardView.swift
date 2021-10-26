import UIKit

//店舗写真バージョン
class StoreCardView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    //MARK: UIViews
    private let cardImageView = CardImageView(frame: .zero)
    private let nameLabel: UILabel = CardInfoLabel(font: .systemFont(ofSize: 40, weight: .heavy))
    private let ageLabel: UILabel  = CardInfoLabel(font: .systemFont(ofSize: 28, weight: .regular))
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    private let residenceLabel = CardInfoLabel(font: .systemFont(ofSize: 20, weight: .regular))
    private let hobbyLabel = CardInfoLabel(font: .systemFont(ofSize: 25, weight: .regular))
    private let introductionLabel = CardInfoLabel(font: .systemFont(ofSize: 25, weight: .regular))
    private let goodLabel: UILabel = CardInfoLabel(text: "GOOD", textColor: .rgb(red: 137, green: 223, blue: 86))
    private let nopeLabel: UILabel = CardInfoLabel(text: "NOPE", textColor: .rgb(red: 222, green: 110, blue: 110))
    
    private var pageIndex = 0
    private var store: Store?
    
    init(store: Store) {
        super.init(frame: .zero)
        setUpLayout(store: store)
        setupGradientLayer()
        self.store = store
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCardView))
        
        tapGesture.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        guard  let view = gesture.view else { return }
        if gesture.state == .changed {
            self.handlePanChange(translation: translation)
        } else if  gesture.state == .ended {
            self.handlePanEnded(view: view, translation: translation)
        }
    }
    
    @objc private func tapCardView(gesture: UITapGestureRecognizer) {
        let tapPoint = gesture.location(in: self)
        recognizeTapPoint(tapPoint: tapPoint)
    }
    
    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.3, 1.1]
        cardImageView.layer.addSublayer(gradientLayer)
        
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    private func handlePanChange(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 100
        
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        
        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        
        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
        
    }
    
    private func handlePanEnded(view: UIView, translation: CGPoint) {
        
        if translation.x <= -120 {
            view.removeCardViewAnimation(x: -600)
            
        } else if translation.x >= 120 {
            view.removeCardViewAnimation(x: 600)

        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                self.transform = .identity
                self.layoutIfNeeded()
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }
        
    }
    
    private func recognizeTapPoint(tapPoint: CGPoint) {
        let halfViewlLength = self.frame.width / 2
        if tapPoint.x <= halfViewlLength {
            if pageIndex != 0 {
                pageIndex -= 1
                cardImageView.image = store?.images[pageIndex]
            }
        } else if tapPoint.x >= halfViewlLength {
            if pageIndex < (store?.images.count)! - 1 {
                pageIndex += 1
                cardImageView.image = store?.images[pageIndex]
            }
        }
    }
    
    private func setUpLayout(store: Store) {
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        baseStackView.axis = .horizontal
        
        //Viewの配置を作成
        addSubview(cardImageView)
        addSubview(nameLabel)
        //addSubview(ageLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)
        
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        //ageLabel.anchor(bottom: baseStackView.topAnchor, left: nameLabel.rightAnchor, bottomPadding: 10, leftPadding: 10)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 20)
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 20)
        
        nameLabel.text = store.name
        cardImageView.image = store.images[0]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
