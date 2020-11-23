//
//  MapView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    private let mapView = MKMapView()
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.register(MarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    
    func makeCoordinator() -> MKMapViewCoordinator {
        return MKMapViewCoordinator(mapView: self)
    }
    
    class MKMapViewCoordinator: NSObject, MKMapViewDelegate {
        
        var mapView: MapView
        
        init(mapView: MapView) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }
            guard !(annotation is MKClusterAnnotation) else { return nil }
            
            var annotationView: MarkerView
            if let markerView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MarkerView {
                markerView.annotation = annotation
                annotationView = markerView
            } else {
                annotationView = MarkerView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                annotationView.animatesWhenAdded = true
            }
            return annotationView
            
        }
        
    }
    
    func addAnnotations(_ annotations: [Artwork]) -> Self {
        self.mapView.addAnnotations(annotations)
        return self
    }
    
    func setRegion(_ coordinates: CLLocationCoordinate2D?, span: MKCoordinateSpan) -> Self {
        guard let coordinates = coordinates else { return self }
        let region = MKCoordinateRegion(center: coordinates, span: span)
        self.mapView.setRegion(region, animated: true)
        return self
    }
}


