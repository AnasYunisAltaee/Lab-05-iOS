//
//  ios5_vieire_AltaeeApp.swift
//  ios5_vieire_Altaee
//
//  Created by Anas Altaee on 11.01.25.
//

import SwiftUI

@main
struct ios5_vieire_AltaeeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        viewModel.addressBook.save()
                        
                    }
                }
        }
    }
}
