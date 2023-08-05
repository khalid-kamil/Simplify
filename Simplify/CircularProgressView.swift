//
//  CircularProgressView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct CircularProgressView: View {
  var value: Int
  let target: Int

  var progress: Double {
    switch value {
    case 0:
      return 1/10_000
    default:
      return Double(value) / Double(target)
    }
  }

  var body: some View {
    ZStack {
      Circle()
        .stroke(Color(.systemYellow).opacity(0.2), lineWidth: 24)
      Circle()
        .trim(from: 0, to: progress)
        .stroke(Color(.systemYellow), style: StrokeStyle(lineWidth: 24, lineCap: .round))
        .rotationEffect(.degrees(-90))
      Text(progress == 1 ? "🎉" : "\(value)/\(target)")
    }
    .animation(.easeInOut, value: progress)
  }
}

struct CircularProgressView_Previews: PreviewProvider {
  static var previews: some View {
    CircularProgressView(value: 1, target: 10)
      .previewDisplayName("Circular Progress View")
      .previewLayout(.sizeThatFits)
      .padding()
      .frame(width: 200, height: 200)
  }
}
