import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let registerViewController = RegisterViewController()
            registerViewController.modalPresentationStyle = .fullScreen
            self.present(registerViewController, animated: true, completion: nil)
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
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)]
            .forEach { $0.isActive = true }
    }
    

}

