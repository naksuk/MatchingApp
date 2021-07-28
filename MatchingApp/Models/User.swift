import Foundation
import FirebaseFirestore

class User {
    
    var uid: String
    var email: String
    var name: String
    var createdAt: Timestamp
    var age: String
    var residence: String
    var hobby: String
    var introduciton: String
    var profileImageUrl: String
    
    init (dic: [String: Any]) {
        self.uid = dic["uid"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.age = dic["age"] as? String ?? ""
        self.residence = dic["residence"] as? String ?? ""
        self.hobby = dic["hobby"] as? String ?? ""
        self.introduciton = dic["introduction"] as? String ?? ""
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
    }
    
}
