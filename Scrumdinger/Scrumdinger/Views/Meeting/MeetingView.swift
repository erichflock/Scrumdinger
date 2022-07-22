//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Erich Flock on 17.06.22.
//

import SwiftUI

struct MeetingView: View {
    
    @Binding var scrum: DailyScrum
    @StateObject var timer = ScrumTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: timer.secondsElapsed, secondsRemaining: timer.secondsRemaining, theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                
                HStack {
                    Text("Speaker 1 of 3")
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
