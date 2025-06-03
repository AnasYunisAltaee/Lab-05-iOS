//
//  ContentView.swift
//  ios5_vieire_Altaee
//
//  Created by Anas Altaee on 11.01.25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.addressBook.addressCards) { card in
                    NavigationLink(destination: DetailView(card: card, viewModel: viewModel)) {
                        Text("\(card.firstName) \(card.lastName), \(card.street)")
                            .padding(.bottom, 5)
                            .font(.headline)
                        
                        Text("\(card.street), \(card.postalCode) \(card.city)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete { indexSet in
                    viewModel.addressBook.addressCards.remove(atOffsets: indexSet)
                    viewModel.updateViews()
                }
            }
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        DetailView(card: AddressCard(), viewModel: viewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Address Book")
        }
    }
}

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var card: AddressCard
    @ObservedObject var viewModel: ViewModel
    @State var addFriendName: String = ""
    @State private var newHobby: String = ""

    var body: some View {
        List {
            Section(header: Text("Data")) {
                TextField("First Name", text: $card.firstName)
                TextField("Last Name", text: $card.lastName)
                TextField("Address", text: $card.street)
                HStack {
                    Text("Postal code")
                    TextField("Postal Code", value: $card.postalCode, formatter: NumberFormatter())
                }
                TextField("City", text: $card.city)
            }

            // Abschnitt für Hobbys
            Section(header: Text("Hobbies")) {
                Button("Add Hobby") {
                    let hobby = Hobby(name: newHobby)
                    card.hobbies.append(hobby)
                    newHobby = ""
                    viewModel.updateViews()
                }
                TextField("New Hobby", text: $newHobby)

                ForEach($card.hobbies) { $hobby in
                    HStack {
                        TextField("Hobby", text: $hobby.name)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        card.hobbies.remove(at: index)
                    }
                    viewModel.updateViews()
                }
            }

            // Abschnitt für Freunde
            Section(header: Text("Friends")) {
                TextField("Add Friend", text: $addFriendName)
                Button("Add Friend") {
                    viewModel.addFrends(card: card, friendName: addFriendName)
                }

                ForEach(viewModel.addressBook.friendsOf(card: card)) { friend in
                    Text("\(friend.firstName) \(friend.lastName)")
                }
            }

            //Spacer()
        }
        //.padding()
        .navigationTitle("Edit Address Card")
        .navigationBarItems(trailing: Button("Save") {
            viewModel.saveOrUpdate(card: card)
            dismiss()
        })
    }
}
