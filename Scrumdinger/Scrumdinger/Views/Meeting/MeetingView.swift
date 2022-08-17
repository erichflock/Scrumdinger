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
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
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
                
                MeetingTimerView(speakers: timer.speakers, theme: scrum.theme)
                
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
            
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            isRecording = true
        }
        .onDisappear() {
            timer.stopScrum()
            speechRecognizer.stopTranscribing()
            isRecording = false
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrum.timer.secondsElapsed / 60)
            scrum.history.insert(newHistory, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
