import Foundation
import UIKit

class Store {
    
    var name: String
    var images: [UIImage]
    
    init(dic: [String: Any]) {
        self.name = dic["name"] as? String ?? "サンプル店"
        self.images = dic["images"] as? [UIImage] ?? [UIImage]()
    }
    
}
