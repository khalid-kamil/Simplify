
import Foundation

struct Habit {
    var name: String
    var currentStreak: Int
    var currentMilestoneIndex: Int
    var isCompleted: Bool = false
    lazy var isReminderOn: Bool = false
}
