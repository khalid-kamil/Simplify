//
//  UserSettings.swift
//  Simplify
//
//  Created by Khalid Kamil on 08/08/2023.
//

import SwiftUI

class UserSettings: ObservableObject {
  @Published var habitColor: Color {
    didSet {
      UserDefaults.standard.saveColor(habitColor, forKey: "HABIT_COLOR")
    }
  }
  
  @Published var task1Color: Color {
    didSet {
      UserDefaults.standard.saveColor(task1Color, forKey: "TASK_ONE_COLOR")
    }
  }

  @Published var task2Color: Color {
    didSet {
      UserDefaults.standard.saveColor(task2Color, forKey: "TASK_TWO_COLOR")
    }
  }

  @Published var task3Color: Color {
    didSet {
      UserDefaults.standard.saveColor(task3Color, forKey: "TASK_THREE_COLOR")
    }
  }

  init() {
    self.habitColor = UserDefaults.standard.loadColor(forKey: "HABIT_COLOR") ?? Color.yellow
    self.task1Color = UserDefaults.standard.loadColor(forKey: "TASK_ONE_COLOR") ?? Color.purple
    self.task2Color = UserDefaults.standard.loadColor(forKey: "TASK_TWO_COLOR") ?? Color.orange
    self.task3Color = UserDefaults.standard.loadColor(forKey: "TASK_THREE_COLOR") ?? Color.cyan
  }
}

extension UserDefaults {
  func saveColor(_ color: Color, forKey key: String) {
    let color = UIColor(color).cgColor

    if let components = color.components {
      self.set(components, forKey: key)
    }
  }

  func loadColor(forKey key: String) -> Color? {
    guard let array = self.object(forKey: key) as? [CGFloat] else { return nil }

    let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2])

    return color
  }
}
