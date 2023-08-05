//
//  HabitView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct HabitView: View {
  var name: String
  var isCompleted: Bool
  @Binding var isReminderOn: Bool
  var target: Int
  @Binding var currentStreak: Int
  var nextMilestone: Int

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Image(systemName: isReminderOn ? "bell.fill" : "bell.slash")
          .onTapGesture {
            isReminderOn.toggle()
          }
        Text(name)
          .font(.title3)
          .fontWeight(.medium)
        Button {
          currentStreak += 1
        } label: {
          HStack {
            Image(systemName: "checkmark.circle")
            Text("Complete")
          }

        }
      }
      Spacer()
      VStack() {
        CircularProgressView(currentStreak: currentStreak, nextMilestone: nextMilestone)
          .padding()
      }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: 180)
    .background(.thinMaterial)
    .cornerRadius(12)
  }
}

struct HabitView_Previews: PreviewProvider {
  static var previews: some View {
    HabitView(name: "Pray Fajr on time at masjid",
              isCompleted: false,
              isReminderOn: .constant(false),
              target: 28,
              currentStreak: .constant(0),
              nextMilestone: 10)
    .previewDisplayName("Habit View")
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
