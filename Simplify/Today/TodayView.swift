//
//  TodayView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct TodayView: View {
  @EnvironmentObject var userSettings: UserSettings
  @StateObject var vm = TodayViewModel()

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading) {
          Text("Habit")
            .font(.title2)
            .fontWeight(.semibold)
            ZStack {
                if let habit = vm.habit {
                    HabitView(habit: habit)
                } else {
                    VStack {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 2)
                        Text("Add habit".uppercased())
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(userSettings.habitColor)
                    .onTapGesture {
                        vm.addHabit(name: "Complete 30 mins of touch typing")
                    }
                }

            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 180)
            .background(.thinMaterial)
            .cornerRadius(12)

          Section {
              Text("Task 1")
                .foregroundColor(userSettings.task1Color)
              Text("Task 2")
                .foregroundColor(userSettings.task2Color)
              Text("Task 3")
                .foregroundColor(userSettings.task3Color)
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
      .toolbar {
        ToolbarItem {
          Button {
            // Change day
              vm.today = Calendar.current.date(byAdding: .day, value: 1, to: vm.today)!
              vm.habit?.newDay()
          } label: {
              Text(vm.today.formatted(date: .abbreviated, time: .omitted))
          }
        }
      }
    }
  }
}

struct TodayView_Previews: PreviewProvider {
  static let userSettings = UserSettings()
  static var previews: some View {
    TodayView()
      .environmentObject(userSettings)
  }
}
