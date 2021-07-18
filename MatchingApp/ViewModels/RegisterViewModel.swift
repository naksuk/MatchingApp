import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelsInputs {
    var nameTextInput: AnyObserver<String> { get }
    var emailTextInput: AnyObserver<String> { get }
    var passwordTextInput: AnyObserver<String> { get }
}

protocol RegisterViewModelOutputs {
    var nameTextOutput: PublishSubject<String> { get }
    var emailTextOutput: PublishSubject<String> { get }
    var passwordTextOutput: PublishSubject<String> { get }
}

class RegisterViewModel: RegisterViewModelsInputs, RegisterViewModelOutputs {
    
    
    private let disposedBag = DisposeBag()
    
    // MRAK: observable
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
    
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
    
    var validRegisterDriver: Driver<Bool> = Driver.never()
    
    init() {
        
        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let nameVaild = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        
        let emailVailid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        
        let passwordVaild = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        
        Observable.combineLatest(nameVaild, emailVailid, passwordVaild) { $0 && $1 && $2 }
            .subscribe{ validAll in
                self.validRegisterSubject.onNext(validAll)
            }
            .disposed(by: disposedBag)
        
    }
    
    
}
