//
//  Refreshing.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/21/24.
//

//import SwiftUI
//import Combine
//
//struct Refreshing: View {
//    @StateObject private var viewModel = DataViewModel()
//
//    var body: some View {
//        VStack {
//            Text(viewModel.data)
//                .padding()
//            
//            Button {
//                viewModel.refreshData()
//            } label: {
//                Text("Refresh Data")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//    }
//}
//
//class DataViewModel: ObservableObject {
//    @Published var data: String = "Initial Data"
//
//    func refreshData() {
//        // Simulate fetching new data (e.g., from a network or database)
//        self.data = "Refreshed Data: \(Date())"
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Refreshing()
//    }
//}
