
import Foundation

class AddressBook: Codable {
    // Liste von Adresskarten
    var addressCards: [AddressCard]
    
    // Initializer
    init() {
        self.addressCards = []
    }
    
    // Hinzufügen einer Adresskarte
    func add(card: AddressCard) {
        addressCards.append(card)
    }
    
    // Entfernen einer Adresskarte
    func remove(card: AddressCard) {
        // Entferne die Karte aus dem Adressbuch
        if let index = addressCards.firstIndex(of: card) {
            addressCards.remove(at: index)
        }
        // Entferne alle Freundes-Referenzen auf diese Karte
        for addressCard in addressCards {
            addressCard.friends.removeAll { $0 == card.id }
        }
    }
    
    // Sortieren des Adressbuchs nach Nachnamen
    func sort() {
        addressCards.sort { $0.lastName < $1.lastName }
    }
    
    // Suche einer Karte nach einem Nachnamen
    func search(byLastName lastName: String) -> AddressCard? {
        return addressCards.first { $0.lastName == lastName }
    }
    // search for lastName
    func findByLastName(_ lastName: String) -> [AddressCard] {
        return addressCards.filter { $0.lastName == lastName }
    }
    
    // Suche einer Karte nach einer id
    func search(byID id: UUID) -> AddressCard? {
        return addressCards.first { $0.id == id }
    }
    
    // Freunde einer Karte zurückgeben
    func friendsOf(card: AddressCard) -> [AddressCard] {
        var friends: [AddressCard] = []
        for friendID in card.friends {
            if let friend = search(byID: friendID) {
                friends.append(friend)
            }
        }
        return friends
    }
    
    // Archivieren des Adressbuchs in eine Datei
    func save() {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("AddressBook.json") else { return }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self) {
            try? data.write(to : path)
        }
    }
    
    // Klassen-Methode zum Erzeugen eines Adressbuchs aus einer Datei
    class func fromFile() -> AddressBook? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("AddressBook.json") else { return nil }
        let decoder = JSONDecoder()
        if let data = try? Data(contentsOf: path),
           let addressBook = try? decoder.decode(AddressBook.self, from: data) {
            return addressBook
        }
        return nil
    }
}

