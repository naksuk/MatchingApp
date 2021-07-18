
import Firebase
import FirebaseAuth
import FirebaseFirestore
// MARK: - Auth
extension Auth {
    static func createUserToFireAuth(email: String?, password: String?, name: String?, completion: @escaping (Bool) -> Void) {
        guard let email = email else { return }
        guard let password = password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("auth情報の保存に失敗: ", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            Firestore.setUserDataToFirestore(uid: uid, email: email, name: name) { success in
                completion(success)
            }
        }
    }
}

// MARK: - Firestore

extension Firestore {
    
    static func setUserDataToFirestore(uid: String, email: String, name: String?, completion: @escaping (Bool) -> ()) {
        guard let name = name else { return }
        
        let document = [
            "name": name,
            "email": email,
            "createdAt": Timestamp()
        ] as [String: Any]
        
        Firestore.firestore().collection("users").document(uid).setData(document) { (err) in
            if let err = err {
                print("ユーザ情報保存失敗: ", err)
                return
            }
            completion(true)
            print("ユーザ情報保存成功")
        }
    }
    
}
