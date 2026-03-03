//
//  App.swift
//  LoginApp
//
//  Created by Generated Code
//

import SwiftUI

@main
struct LoginApp: App {
    @State private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
