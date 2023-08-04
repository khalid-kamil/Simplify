//
//  TodayView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct TodayView: View {
  var body: some View {
    NavigationStack {
      ScrollView {
        Section {

        } header: {
          Text("Habit")
            .font(.title2)
            .fontWeight(.semibold)
        }

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
      .navigationTitle("Today")
    }
  }
}

struct TodayView_Previews: PreviewProvider {
  static var previews: some View {
    TodayView()
  }
}
