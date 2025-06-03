import Foundation

class Hobby : Identifiable, Codable, Equatable {
    let id : UUID
    var name : String
    init(){
        self.id = UUID()
        self.name = ""
    }
    init (name: String) {
        self.id = UUID()
        self.name = name
    }
    static func == (links: Hobby, rechts: Hobby) -> Bool{
        return links.id == rechts.id
        
    }
//    func vergleischId(first : Hobby , scound : Hobby) -> Bool{
//        if first.id == scound.id{
//            return true
//        }else{
//            return false
//        }
//    }
    
}
