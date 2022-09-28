//
//  MainView.swift
//  SpaceX API iOS Example
//
//  Created by Tadreik Campbell on 9/28/22.
//

import SwiftUI

struct MainView: View {
    
    @State var orientation = UIDevice.current.orientation
    
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    @State private var launches: [DataObject] = []
    
    var vc: UIViewController?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(launches) { obj in
                    if orientation.isLandscape {
                        DataObjectViewCompact(obj: obj)
                            .onTapGesture {
                                vc?.show(DetailViewController(object: obj), sender: nil)
                            }
                    } else {
                        DataObjectView(obj: obj)
                            .onTapGesture {
                                vc?.show(DetailViewController(object: obj), sender: nil)
                            }
                    }
                }
            }
        }
        .onAppear {
            getData()
        }
        .onReceive(orientationChanged) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }
    
    func getData() {
        Network().getData { objects, error in
            launches += objects
        }
    }
}

struct DataObjectView: View {
    
    var obj: DataObject
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: obj.launchPatchImage) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(width: 250, height: 250)
            Text("Mission: \(obj.missionName ?? "No name")")
            Text("Rocket: \(obj.rocketName)")
            Text("Launch site: \(obj.launchSite.siteName ?? "")")
        }
    }
}

struct DataObjectViewCompact: View {
    
    var obj: DataObject
    
    var body: some View {
        HStack {
            VStack {
                AsyncImage(url: obj.launchPatchImage) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 100, height: 100)
                
            }
            VStack {
                Text("Mission: \(obj.missionName ?? "No name")")
                Text("Rocket name: \(obj.rocketName)")
            }
            
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
