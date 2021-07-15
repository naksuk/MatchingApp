import Foundation
import RxSwift

class RegisterViewModel {
    
    private let disposedBag = DisposeBag()
    
    // MRAK: observable
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    
    // MARK: observer
    var nameTextInput: AnyObserver<String> {
        nameTextOutput.asObserver()
    }
    
    var emailTextInput: AnyObserver<String> {
        emailTextOutput.asObserver()
    }
    
    var passwordTextInput: AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    
    init() {
        nameTextOutput
            .asObservable()
            .subscribe { text in
                print("name: ", text)
            }
            .disposed(by: disposedBag)
        
        emailTextOutput
            .asObservable()
            .subscribe { text in
                print("email: ", text)
            }
            .disposed(by: disposedBag)
        
        passwordTextOutput
            .asObservable()
            .subscribe { text in
                print("password: ", text)
            }
            .disposed(by: disposedBag)
        
    }
    
    
}
