//
//  Model.swift
//  SampleDataFetch
//
//  Created by Md. Asiuzzaman on 20/3/25.
//

import Foundation
import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}
