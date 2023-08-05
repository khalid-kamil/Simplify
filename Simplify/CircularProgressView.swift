//
//  CircularProgressView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct CircularProgressView: View {
  var currentStreak: Int
  let nextMilestone: Int

  var progress: Double {
    switch currentStreak {
    case 0:
      return 1/10_000
    default:
      return Double(currentStreak) / Double(nextMilestone)
    }
  }

  var body: some View {
    ZStack {
      Circle()
        .stroke(Color.pink.opacity(0.2), lineWidth: 24)
      Circle()
        .trim(from: 0, to: progress)
        .stroke(Color.pink, style: StrokeStyle(lineWidth: 24, lineCap: .round))
        .rotationEffect(.degrees(-90))
        .animation(.easeOut, value: progress)
      Text("\(currentStreak)/\(nextMilestone)")
    }
  }
}

struct CircularProgressView_Previews: PreviewProvider {
  static var previews: some View {
    CircularProgressView(currentStreak: 0, nextMilestone: 10)
      .previewDisplayName("Circular Progress View")
      .previewLayout(.sizeThatFits)
      .padding()
      .frame(width: 200, height: 200)
  }
}
