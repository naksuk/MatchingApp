import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            let registerViewController = RegisterViewController()
//            let nav = UINavigationController(rootViewController: registerViewController)
//            nav.modalPresentationStyle = .fullScreen
//            self.present(nav, animated: true, completion: nil)
//        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser?.uid == nil {
            let registerViewController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    private func setupLayout() {
        
        view.backgroundColor = .white
        
        let topControlView = TopControlView()
        topControlView.backgroundColor = .white
        
        let cardView = CardView()
        cardView.backgroundColor = .white
        
        let bottomControlView = BottomControlView()
        //view3.backgroundColor = .green
        
        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        //stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)]
            .forEach { $0.isActive = true }
        
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
        
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
        

    }
    
    @objc private func tappedLogoutButton() {
        do {
            try Auth.auth().signOut()
            let registerViewController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("ログアウトに失敗", error)
        }
        
    }

}

