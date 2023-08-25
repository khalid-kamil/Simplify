//
//  SettingsView.swift
//  Simplify
//
//  Created by Khalid Kamil on 05/08/2023.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var userSettings: UserSettings

  var body: some View {
    NavigationStack {
      Form {
        Section("Color Themes") {
          ColorPicker("Habit", selection: $userSettings.habitColor, supportsOpacity: false)
          ColorPicker("Task 1", selection: $userSettings.task1Color, supportsOpacity: false)
          ColorPicker("Task 2", selection: $userSettings.task2Color, supportsOpacity: false)
          ColorPicker("Task 3", selection: $userSettings.task3Color, supportsOpacity: false)
        }
      }
      .navigationTitle("Settings")
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static let userSettings = UserSettings()
  static var previews: some View {
    SettingsView()
      .environmentObject(userSettings)
  }
}
