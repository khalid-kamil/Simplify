//
//  MainView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct MainView: View {
  @StateObject var userSettings = UserSettings()
    var body: some View {
      TabView {
        TodayView()
          .tabItem {
            Label("Today", systemImage: "target")
          }
        SummaryView()
          .tabItem {
            Label("Summary", systemImage: "calendar")
          }
        SettingsView()
          .tabItem {
            Label("Settings", systemImage: "gearshape.fill")
          }
      }
      .environmentObject(userSettings)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
