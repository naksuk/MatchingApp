import UIKit
import RxSwift
import FirebaseAuth
import PKHUD

class LoginViewController: UIViewController {
    
    private let disposedBag = DisposeBag()
    
    //MARK: UIViews
    private let titleLabel = RegisterTitleLabel(text: "Kender")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let loginButton = RegisterButton(text: "ログイン")
    private let dontHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "アカウントをお持ちでない方はこちら")
    
    override func viewDidLoad() {
        setupGradientLayer()
        setupLayout()
        setupBindings()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupGradientLayer() {
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 288, blue: 108).cgColor
        
        let layer = CAGradientLayer()
        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.frame = view.bounds
        view.layer.addSublayer(layer)

    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func setupLayout() {
        passwordTextField.isSecureTextEntry = true
        let baseStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(dontHaveAccountButton)
        
        emailTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 20, rightPadding: 20)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        dontHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
    }
    
    private func setupBindings() {
        
        dontHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposedBag)
        
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.loginWithFireAuth()
            }
            .disposed(by: disposedBag)
    }
    
    private func loginWithFireAuth() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        HUD.show(.progress)
        Auth.loginWithFireAuth(email: email, password: password) { (success) in
            HUD.hide()
            if success {
                self.dismiss(animated: true)
            } else {
                
            }
            
        }
    }
    
}
