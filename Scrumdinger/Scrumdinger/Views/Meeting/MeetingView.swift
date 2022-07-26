//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Erich Flock on 17.06.22.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    
    @Binding var scrum: DailyScrum
    @StateObject var timer = ScrumTimer()
    
    private var player: AVPlayer {
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        return AVPlayer.sharedDingPlayer
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: timer.secondsElapsed, secondsRemaining: timer.secondsRemaining, theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                
                MeetingFooterView(speakers: timer.speakers, skipAction: timer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear() {
            timer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            timer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            timer.startScrum()
        }
        .onDisappear() {
            timer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
