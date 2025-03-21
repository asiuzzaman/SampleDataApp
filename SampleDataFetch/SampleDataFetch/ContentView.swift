//
//  ContentView.swift
//  SampleDataFetch
//
//  Created by Md. Asiuzzaman on 20/3/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    // Fetch data from Core Data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    VStack(alignment: .leading) {
                        Text(item.title ?? "Untitled")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                Button(action: {
                    viewModel.fetchData()
                }) {
                    Label("Fetch Data", systemImage: "arrow.clockwise")
                }
            }
        }
    }
}
