
import SwiftUI

struct SummaryView: View {
    @StateObject var tracker = Tracker.shared
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(1..<13) { month in
                    VStack(alignment: .leading) {
                        Text("Month \(month)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        LazyVGrid(columns: columns) {
                            ForEach((1..<31)) { day in
                                NavigationLink {
                                    Text("Log Entry")
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(.gray)
                                            .frame(width: 32, height: 32)
                                        Text(String(describing: day))
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                    }

                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Summary")
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
