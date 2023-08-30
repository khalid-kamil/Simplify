
import Foundation

class Tracker: ObservableObject {
    static let shared = Tracker()

    private init(today: Date = Date(), habit: Habit? = nil, currentMilestoneIndex: Int = 0, currentStreak: Int = 0) {
        self.today = today
        self.habit = habit
        self.currentMilestoneIndex = currentMilestoneIndex
        self.currentStreak = currentStreak
    }

    var today: Date
    var habit: Habit?
    let target: Int = 28
    let milestones: [Int] = [1, 2, 3, 5, 7, 10, 14, 21, 28]
    var currentMilestoneIndex: Int
    var currentStreak: Int

    var targetAchieved: Bool {
        return habit?.currentStreak ?? 0 == target
    }

    @Published var database = [Entry]()

    func createHabit(name: String, isCompleted: Bool = false) {
        
    }

    func deleteHabit() {
        habit = nil
    }

    func newDay() {
        guard let habit = habit else { return }

        if !habit.isCompleted {
            currentStreak = 0
            currentMilestoneIndex = 0
        } else {
            if currentStreak == milestones[currentMilestoneIndex] && currentMilestoneIndex + 1 < milestones.count {
                currentMilestoneIndex += 1
            }
        }

        createHabit(name: habit.name!, isCompleted: habit.isCompleted)
        database.append(Entry(date: today, habit: self.habit!))
        print(Entry(date: today, habit: habit).habit.currentStreak)
        createHabit(name: habit.name!)
    }
}


struct Entry {
    let date: Date
    let habit: Habit
}

