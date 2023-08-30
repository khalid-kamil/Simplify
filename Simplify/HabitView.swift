//
//  HabitView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct HabitView: View {
    let habit: Habit

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                notificationBell
                habitName
                Spacer()
                markHabitAsCompletedButton
            }
            Spacer()
            circularProgressView
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: Habit())
            .previewDisplayName("Habit View Light")
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(height: 180)
    }
}

extension HabitView {
    var notificationBell: some View {
        Image(systemName: habit.allowsNotifications ? "bell.fill" : "bell.slash")
            .onTapGesture {
                habit.allowsNotifications.toggle()
                // TODO: Enable notifications
                // TODO: Trigger haptic feedback
            }
            .rotationEffect(.degrees(habit.allowsNotifications ? -30 : 0), anchor: .top)
            .animation(.interpolatingSpring(stiffness: 200, damping: 6), value: habit.allowsNotifications)
            .foregroundColor(Color(habit.color))
    }

    var habitName: some View {
        Text(habit.name ?? "N/A")
            .font(.title3)
            .fontWeight(.medium)
    }

    var markHabitAsCompletedButton: some View {
        Button {
            // MARK: Mark Habit as completed
            
        } label: {
            HStack(spacing: 4) {
                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                Text(habit.isCompleted ? "Done!" : "Mark as done")
            }
            .fontWeight(.semibold)
        }
        .buttonStyle(.bordered)
        .tint(Color(habit.color))
        .disabled(habit.isCompleted)
    }

    var circularProgressView: some View {
        CircularProgressView(value: Int(habit.currentStreak), target: Tracker.shared.milestones[Int(habit.currentMilestoneIndex)], color: Color(habit.color))
            .padding()
    }
}
