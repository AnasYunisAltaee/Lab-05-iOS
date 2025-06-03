//
//  AddressBookViewModel.swift
//  ios3-vieira-altaee
//
//  Created by Anas Altaee on 11.01.25.
//
import Foundation


class ViewModel: ObservableObject {
    @Published var addressBook : AddressBook

    init() {
        self.addressBook = AddressBook.fromFile() ?? AddressBook()
    }

    func updateViews() {
        objectWillChange.send()
    }
    func saveOrUpdate(card: AddressCard) {
            // Prüfen, ob die Karte schon existiert
            if let index = addressBook.addressCards.firstIndex(where: { $0.id == card.id }) {
                // Existierende Karte aktualisieren
                addressBook.addressCards[index] = card
            } else {
                // Neue Karte hinzufügen
                addressBook.add(card: card)
            }
            // Ansicht aktualisieren
            updateViews()
            // Daten persistent speichern
            addressBook.save()
        }
    
    func addHobby(card: AddressCard, hobbyName: String) {
        let hobby = Hobby(name: hobbyName) // Neues Hobby erstellen
        card.add(hobby: hobby)
        updateViews()

    }
    
    func addFrends(card: AddressCard, friendName: String) {
        let friendCards = addressBook.findByLastName(friendName)
        
        if friendCards.isEmpty {
            return
        }
        
        let friend = friendCards[0]
        card.add(friend: friend)
        updateViews()
    }
    
   
}






//// Textfeld für das neue Hobby
//TextField("Add new hobby", text: $newHobby)
//    .padding()
//Button("Add Hobby") {
//    if !newHobby.isEmpty {
//        let hobby = Hobby(name: newHobby) // Neues Hobby erstellen
//        card.add(hobby: hobby) // Das Hobby der AddressCard hinzufügen
//        newHobby = "" // Textfeld zurücksetzen
//        viewModel.updateViews() // Views aktualisieren
//    }
