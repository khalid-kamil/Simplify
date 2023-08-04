//
//  MainView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      TabView {
        Color(.blue)
          .tabItem {
            Label("Today", systemImage: "target")
          }
        Color(.green)
          .tabItem {
            Label("Summary", systemImage: "calendar")
          }
        Color(.systemPink)
          .tabItem {
            Label("Settings", systemImage: "gearshape.fill")
          }
      }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
