import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()
    
    //MARK: UIViews
    private let titleLabel = RegisterTitleLabel(text: "Kender")
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let registerButton = RegisterButton(text: "登録")
    private let alreadyHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "既にアカウントをお持ちの場合はこちら")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Methos
    private func setupLayout() {
        passwordTextField.isSecureTextEntry = true
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccountButton)
        
        nameTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 20, rightPadding: 20)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        alreadyHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
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
    
    private func setupBindings() {
        
        // textFieldのBuinding
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        //buttonのbindings
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.createUser()
            }
            .disposed(by: disposeBag)
        
        alreadyHaveAccountButton.rx.tap
            .asDriver()
            .drive { [ weak self] _ in
                let login = LoginViewController()
                self?.navigationController?.pushViewController(login, animated: true)
            }
            .disposed(by: disposeBag)
        
        //viewmodelのbinding
        viewModel.validRegisterDriver
            .drive { validAll in
                print("validAll: ", validAll)
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) :
                    .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    private func createUser() {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
         
        HUD.show(.progress)
        Auth.createUserToFireAuth(email: email, password: password, name: name) { success in
            HUD.hide()
            if success {
                print("処理が終了")
                self.dismiss(animated: true)
            } else {
                
            }
        }
    }
}
