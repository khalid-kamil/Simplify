//
//  HabitView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct HabitView: View {
  let habitColor = Color(.systemYellow)
  var name: String
  @Binding var isCompleted: Bool
  @Binding var isReminderOn: Bool
  var target: Int
  @Binding var currentStreak: Int
  var nextMilestone: Int

  var body: some View {
    HStack(alignment: .top) {
      VStack(alignment: .leading, spacing: 4) {
        Image(systemName: isReminderOn ? "bell.fill" : "bell.slash")
          .onTapGesture {
            isReminderOn.toggle()
            // TODO: Enable notifications
            // TODO: Trigger haptic feedback
          }
          .rotationEffect(.degrees(isReminderOn ? -30 : 0), anchor: .top)
          .animation(.interpolatingSpring(stiffness: 200, damping: 6), value: isReminderOn)
          .foregroundColor(habitColor)
        Text(name)
          .font(.title3)
          .fontWeight(.medium)
        Spacer()
        Button {
          currentStreak += 1
          isCompleted = true
        } label: {
          HStack(spacing: 4) {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
            Text(isCompleted ? "Done!" : "Mark as done")
          }
          .fontWeight(.semibold)
        }
        .buttonStyle(.bordered)
        .tint(.yellow)
        .disabled(isCompleted)
      }
      Spacer()
      CircularProgressView(currentStreak: currentStreak, nextMilestone: nextMilestone)
        .padding()
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
                isCompleted: .constant(false),
                isReminderOn: .constant(false),
                target: 28,
                currentStreak: .constant(0),
                nextMilestone: 10)
      .previewDisplayName("Habit View Light")
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
