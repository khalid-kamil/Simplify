//
//  TodayView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct TodayView: View {
  @State var currentStreak: Int = 0
  @State var isReminderOn = false
  @State var isCompleted = false

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading) {
            Text("Habit")
              .font(.title2)
              .fontWeight(.semibold)
            HabitView(name: "Pray Fajr on time at masjid",
                      isCompleted: $isCompleted,
                      isReminderOn: $isReminderOn,
                      target: 28,
                      currentStreak: $currentStreak,
                      nextMilestone: 10)

          Section {
            ForEach(1..<4) {
              Text("Task \($0)")
            }
          } header: {
            Text("Tasks")
              .font(.title2)
              .fontWeight(.semibold)
          }

          Section {

          } header: {
            Text("Journal")
              .font(.title2)
              .fontWeight(.semibold)
          }
        }
        .padding()
      }
      .navigationTitle("Today")
    }
  }
}

struct TodayView_Previews: PreviewProvider {
  static var previews: some View {
    TodayView()
  }
}
