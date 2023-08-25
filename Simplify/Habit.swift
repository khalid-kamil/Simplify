
import Foundation

struct Habit {
  let target: Int = 28
  let milestones: [Int] = [1, 2, 3, 5, 7, 10, 14, 21]
  let creationDate: Date = Date()
  var currentStreak: Int = 0
  var isCompleted: Bool = false
  var isReminderOn: Bool = false

  var name: String

  var currentMilestoneIndex: Int = 0

  var targetAchieved: Bool {
    return currentStreak == target
  }

  mutating func newDay() {
    if !isCompleted {
      currentStreak = 0
      currentMilestoneIndex = 0
    } else {
      if currentStreak == milestones[currentMilestoneIndex] && currentMilestoneIndex + 1 < milestones.count {
        currentMilestoneIndex += 1
      }
    }
    isCompleted = false
  }
}
