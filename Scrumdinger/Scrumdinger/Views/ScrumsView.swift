//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Erich Flock on 20.06.22.
//

import SwiftUI

struct ScrumsView: View {
    
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.Data()
    @State private var showDetail = false
    let saveAction: () -> Void
    
    var body: some View {
        List($scrums) { $scrum in
            NavigationLink(destination: DetailView(scrum: $scrum),
                           isActive: $showDetail) {
                CardView(scrum: scrum)
            }
                           .simultaneousGesture(TapGesture().onEnded {
                               showDetail.toggle()
                           })
                           .simultaneousGesture(LongPressGesture().onEnded { _ in
                               print("Long Press")
                           })
                           .listRowBackground(scrum.theme.mainColor)
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button {
                isPresentingNewScrumView = true
            } label: {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NavigationView {
                DetailEditView(data: $newScrumData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newScrum = DailyScrum(data: newScrumData)
                                scrums.append(newScrum)
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
