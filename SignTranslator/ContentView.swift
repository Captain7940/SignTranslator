//
//  ContentView.swift
//  SignTranslator
//
//  Created by Thomas on 13/1/2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
        ARViewControllerContainer().edgesIgnoringSafeArea(.all).tabItem ({
        Image(systemName: "hand.raised.fill")
        Text("Translator")
        }).tag(0)

        LocationView().tabItem ({
        Image(systemName: "mappin.and.ellipse")
        Text("Location")
        }).tag(1)
        }
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
