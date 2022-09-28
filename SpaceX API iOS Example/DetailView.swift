//
//  DetailView.swift
//  SpaceX API iOS Example
//
//  Created by Tadreik Campbell on 9/28/22.
//

import SwiftUI

struct DetailView: View {
    
    var obj: DataObject
    
    var body: some View {
        ScrollView {
            DataObjectView(obj: obj)
                .padding(.top)
        }
    }
}


