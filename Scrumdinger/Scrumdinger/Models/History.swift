//
//  History.swift
//  Scrumdinger
//
//  Created by Erich Flock on 26.07.22.
//

import Foundation

struct History: Identifiable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var lengthInMinutes: Int
}
