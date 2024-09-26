//
//  AppViewModel.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI

class AppViewModel: ObservableObject {
    // MARK: Properties
    @Published var currentTab: Tab = .home
    // MARK: Home Properties
    @Published var currentMenu: String = "All"
    // MARK: Detail View Properties
    @Published var showDetailView: Bool = false
    @Published var currentActiveItem: Expense?
}

