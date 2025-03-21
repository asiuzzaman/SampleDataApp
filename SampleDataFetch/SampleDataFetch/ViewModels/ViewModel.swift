//
//  ViewModel.swift
//  SampleDataFetch
//
//  Created by Md. Asiuzzaman on 20/3/25.
//

import Foundation
import CoreData

class ViewModel: ObservableObject {
    @Published var posts = [Post]()

    // Core Data context
    private let context = PersistenceController.shared.container.viewContext

    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Post].self, from: data) {
                    DispatchQueue.main.async {
                        self.posts = decodedResponse
                        self.saveData(decodedResponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }

    func saveData(_ posts: [Post]) {
        // Clear existing data (optional)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error deleting existing data: \(error)")
        }

        // Save new data
        for post in posts {
            let newItem = Item(context: context)
            newItem.id = Int64(post.id)
            newItem.title = post.title
            newItem.body = post.body
        }
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
