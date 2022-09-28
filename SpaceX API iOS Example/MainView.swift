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
    @State private var selectedObject: DataObject? = nil
    
    var vc: UIViewController?
    
    var body: some View {
        if (orientation.isLandscape && UIDevice.current.userInterfaceIdiom == .phone) || UIDevice.current.userInterfaceIdiom == .pad {
            HStack {
                ScrollView {
                    LazyVStack {
                        ForEach(launches) { obj in
                            DataObjectView(obj: obj)
                                .onTapGesture {
                                    selectedObject = obj
                                }
                        }
                    }
                }
                .frame(width: 250)
                Divider()
                if let selectedObject = selectedObject {
                    DataObjectView(obj: selectedObject)
                }
                Spacer()
            }
            .onAppear {
                getData()
            }
            .onReceive(orientationChanged) { _ in
                self.orientation = UIDevice.current.orientation
            }
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(launches) { obj in
                        DataObjectView(obj: obj)
                            .onTapGesture {
                                let detailVC = DetailViewController(object: obj)
                                vc?.show(detailVC, sender: vc)
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
            .frame(width: 200, height: 200)
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
