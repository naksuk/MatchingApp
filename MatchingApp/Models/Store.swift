import Foundation
import UIKit

class Store {
    
    var name: String
    var image: UIImage
    
    init(dic: [String: Any]) {
        self.name = dic["name"] as? String ?? ""
        self.image = dic["image"] as! UIImage
    }
    
}
