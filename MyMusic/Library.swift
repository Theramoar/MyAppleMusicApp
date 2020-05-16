//
//  Library.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 09/02/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert: Bool = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    
    var body: some View {
        NavigationView{
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        },
                               label: {
                                Image(systemName: "play.fill")
                                    .frame(width: geometry.size.width / 2 - 10, height: 50)
                                    .accentColor(Color.init(#colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)))
                                    .background(Color.init(#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)))
                                    .cornerRadius(10)
                        })
                        Button(action: {
                            self.tracks = UserDefaults.standard.savedTracks()
                        },
                               label: {
                                Image(systemName: "arrow.2.circlepath")
                                    .frame(width: geometry.size.width / 2 - 10, height: 50)
                                    .accentColor(Color.init(#colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)))
                                    .background(Color.init(#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)))
                                    .cornerRadius(10)
                        })
                    }
                }
                .padding()
                .frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(LongPressGesture()
                            .onEnded { _ in
                                self.track = track
                                self.showingAlert = true
                            }
                            .simultaneously(with: TapGesture().onEnded { _ in
                                self.track = track
                                self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                            }))
                    }
                    .onDelete(perform: delete)
                    .frame(width: nil, height: 60, alignment: .leading)
                }
            }
            .actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Want to delete this track?"),
                            buttons: [
                                .destructive(Text("Delete"), action: {
                                    self.delete(track: self.track)
                                }),
                                .cancel()])
            })
                .navigationBarTitle("Library")
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        guard let index = tracks.firstIndex(of: track) else { return }
        tracks.remove(at: index)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}


struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) { proxy in
                proxy.image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
