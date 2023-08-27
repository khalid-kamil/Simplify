
import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) var dismiss
    @State var habitName = ""
    @State var isReminderOn = false
    var vm: TodayViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Habit", text: $habitName)
                }

                Section {
                    Toggle("Enable Notifications", isOn: $isReminderOn)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        vm.addHabit(name: habitName)
                        dismiss()
                    }
                    .disabled(habitName.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.hidden)
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        Color.gray
            .ignoresSafeArea()
            .sheet(isPresented: .constant(true)) {
                NewHabitView(vm: TodayViewModel())
            }
    }
}
