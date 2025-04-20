//
//  MainView.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI

struct MainView: View {
    // MARK: View Properties
    @StateObject var appModel: AppViewModel = .init()
    // MARK: Animation Properties
    @Namespace var animation
    // MARK: Hiding Native Tab Bar
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $appModel.currentTab) {
            Home()
                .environmentObject(appModel)
                .tag(Tab.home)
                .setUpTab()
            
            TaskPage()
                .tag(Tab.cart)
                .setUpTab()
            
            Text("Favourite")
                .tag(Tab.favourite)
                .setUpTab()
            
            ProfileTab()
                .tag(Tab.profile)
                .setUpTab()
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(currentTab: $appModel.currentTab, animation: animation)
                .offset(y: appModel.showDetailView ? 150 : 0)
        }
        .overlay {
//            if let furniture = appModel.currentActiveItem,appModel.showDetailView{
//                // MARK: Detail View
//                DetailView(furniture: furniture, animation: animation)
//                    .environmentObject(appModel)
//                    .transition(.offset(x: 1, y: 1))
//            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// MARK: Custom Extensions
extension View{
    @ViewBuilder
    func setUpTab()->some View{
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Color(.systemGray6)
                    .ignoresSafeArea()
            }
    }
}
