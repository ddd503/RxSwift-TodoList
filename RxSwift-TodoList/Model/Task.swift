//
//  Task.swift
//  RxSwift-TodoList
//
//  Created by kawaharadai on 2019/11/01.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low

    var title: String {
        switch self {
        case .high:
            return "high"
        case .medium:
            return "medium"
        case .low:
            return "low"
        }
    }
}

struct Task {
    let title: String
    let priority: Priority
}
