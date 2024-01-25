//
//  MapViewDelegate.swift
//  SignTranslator
//
//  Created by Thomas on 24/1/2024.
//

import MapKit
import UIKit
class MapViewDelegate : NSObject, MKMapViewDelegate {
 func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
 let polygonRenderer = MKPolygonRenderer(overlay: overlay);
 polygonRenderer.strokeColor = UIColor.clear;
 polygonRenderer.fillColor = UIColor.blue;
 polygonRenderer.alpha = 0.5;
 return polygonRenderer;
 }
}
