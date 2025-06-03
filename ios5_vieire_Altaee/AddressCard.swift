import Foundation

class AddressCard: Identifiable, Codable, Equatable, Hashable{
    // Properties
    var id: UUID
    var firstName: String
    var lastName: String
    var street: String
    var postalCode: Int
    var city: String
    var hobbies: [Hobby]
    var friends: [UUID]
    
    // Initializer
    init(){
        self.id = UUID()
        self.firstName = ""
        self.lastName = ""
        self.street = ""
        self.postalCode = 0
        self.city = ""
        self.hobbies = []
        self.friends = []
    }
    init(firstName: String, lastName: String, street: String, postalCode: Int, city: String, hobbies: [Hobby] = [], friends: [UUID] = []) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.postalCode = postalCode
        self.city = city
        self.hobbies = hobbies
        self.friends = friends
    }
    
    // Equatable Protocol
    static func == (links: AddressCard, recht: AddressCard) -> Bool {
        return links.id == recht.id
    }
    
    // Hashable Protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Add a hobby
    func add(hobby: Hobby) {
        hobbies.append(hobby)
    }
    
    // Remove a hobby
    func remove(hobby: Hobby) {
        if let index = hobbies.firstIndex(of: hobby) {
            hobbies.remove(at: index)
        }
    }
    
    // Add a friend
    func add(friend: AddressCard) {
        friends.append(friend.id)
    }
    
    // Remove a friend
    func remove(friend: AddressCard) {
        if let index = friends.firstIndex(of: friend.id) {
            friends.remove(at: index)
        }
    }
}

