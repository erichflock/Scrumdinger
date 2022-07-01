//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Erich Flock on 19.06.22.
//

import Foundation

struct DailyScrum: Identifiable {
    let id = UUID()
    let title: String
    let attendees: [Atendee]
    let lengthInMinutes: Int
    let theme: Theme
    
    init(title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.title = title
        self.attendees = attendees.map { Atendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    
    struct Atendee: Identifiable {
        let id = UUID()
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
}

extension DailyScrum {
    
    static let sampleData: [DailyScrum] =
     [
         DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
         DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .orange),
         DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
     ]
}
