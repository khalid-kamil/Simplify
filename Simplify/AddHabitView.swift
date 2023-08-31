
import SwiftUI

struct AddHabitView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: TodayViewModel

    var body: some View {
        NavigationStack {
            Form {
                habitTitle
                habitColor
                habitNotifications
                if vm.editHabit != nil {
                    deleteHabitButton
                }
            }
            .navigationTitle(vm.editHabit != nil ? "Edit Habit" : "Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { saveButton }
                ToolbarItem(placement: .cancellationAction) { cancelButton }
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.hidden)
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        Color.orange
            .ignoresSafeArea()
            .sheet(isPresented: .constant(true)) {
                AddHabitView()
                    .environmentObject(TodayViewModel())
            }
    }
}

extension AddHabitView {
    var habitTitle: some View {
        Section("Title") {
            TextField("Habit name", text: $vm.habitTitle)
        }
    }

    var habitColor: some View {
        Section("Color") {
            let colors: [String] = ["Blue", "Green", "Purple", "Pink", "Yellow"]

            HStack(spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 25, height: 25)
                        .background {
                            if vm.habitColor == color {
                                Circle()
                                    .strokeBorder(Color(color), lineWidth: 2)
                                    .padding(-4)
                            }
                        }
                        .contentShape(Circle())
                        .onTapGesture {
                            vm.habitColor = color
                        }
                }
            }
        }
    }

    var habitNotifications: some View {
        Section("Notifications") {
            Toggle(isOn: $vm.habitAllowsNotifications) {
                Text("Enable Notifications")
            }
        }
    }

    var deleteHabitButton: some View {
        Button(role: .destructive) {
            if let editHabit = vm.editHabit {
                viewContext.delete(editHabit)
                try? viewContext.save()
                dismiss()
                vm.resetHabitData()
            }
        } label: {
            HStack {
                Image(systemName: "trash")
                Text("Delete Habit")
                    .fontWeight(.medium)
            }
        }
    }

    var saveButton: some View {
        // MARK: Save Habit Button
        Button("Save") {
            // MARK: If successfully saved to CoreData, dismiss view
            if vm.addHabit(context: viewContext) {
                dismiss()
            }
        }
        .disabled(vm.habitTitle.isEmpty)
    }

    var cancelButton: some View {
        // MARK: Cancel Habit Button
        Button("Cancel") {
            dismiss()
        }
    }
    
}
