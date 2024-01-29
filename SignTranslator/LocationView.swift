//
//  LocationView.swift
//  SignTranslator
//
//  Created by Thomas on 24/1/2024.
//


import MapKit
import CoreLocation
import SwiftUI
import Foundation

struct AnnotatedItem : Identifiable {
    let id = UUID()
    let name : String
    var coordinate : CLLocationCoordinate2D
    
}
struct LocationView: View {
     @State var nameStr : String = ""
     @State var latStr : String = ""
     @State var lngStr : String = ""
     @State internal var pointOfInterest = [
     AnnotatedItem(name: "Professional Sign Language Training Centre", coordinate: .init(latitude: 22.360982503174295, longitude: 114.13275752712616)),
     AnnotatedItem(name: "Centre for Sign Linguistics and Deaf Studies, CUHK", coordinate: .init(latitude: 22.42843632278736, longitude: 114.21326670161059)),
     AnnotatedItem(name: "HKSLBTA", coordinate: .init(latitude: 22.288413340559558, longitude: 114.16108164597804))
    ]

    @State private var region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.37464, longitude:
    114.14907), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
     VStack {
         HStack {
             TextField("Name", text: $nameStr).textFieldStyle(.roundedBorder).accessibilityIdentifier("Name")
         TextField("Lat", text: $latStr).textFieldStyle(.roundedBorder).accessibilityIdentifier("Lat")
         TextField("Lng", text: $lngStr).textFieldStyle(.roundedBorder).accessibilityIdentifier("Lng")
         Button("Add", action: {
         addAnnotation()
         }).accessibilityIdentifier("Add")
         }.padding()
     Map(coordinateRegion: $region, annotationItems: pointOfInterest) {
     item in
     MapMarker(coordinate: item.coordinate)
     }
     }
     }
    func addAnnotation() {
        let lat = Double(latStr) ?? 0
        let lng = Double(lngStr) ?? 0
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let annotation = AnnotatedItem(name: nameStr, coordinate: coord)
        self.pointOfInterest.append(annotation)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
