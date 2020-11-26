//
//  MapView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import SwiftUI
import MapKit

struct PEMapView: UIViewRepresentable {
    
    
    @Binding var annotations: [Artwork]
    @Binding var region: MKCoordinateRegion?
        
    var annotationSelectionChangedClosure: ((Artwork?) -> Void)? = nil
    
    fileprivate var selectedAnnotation: Artwork?
    
    init(_ annotations: Binding<[Artwork]>, region: Binding<MKCoordinateRegion?>, selection: Artwork? = nil) {
        self._annotations = annotations
        self._region = region
        self.selectedAnnotation = selection
    }
    
    init(_ annotations: Binding<[Artwork]>, selection: Artwork? = nil) {
        self._annotations = annotations
        self._region = .constant(nil)
        self.selectedAnnotation = selection
    }
    
    func makeUIView(context: UIViewRepresentableContext<PEMapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.register(
            MarkerView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier
        )
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if uiView.annotations.filter({ $0 is Artwork }).count != annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
    
    
    func makeCoordinator() -> MKMapViewCoordinator {
        return MKMapViewCoordinator(mapView: self)
    }
   
    func annotationSelectionChanged(_ annotationSelected: @escaping ((Artwork?) -> Void)) -> Self {
        var mutableCopy = self
        mutableCopy.annotationSelectionChangedClosure = annotationSelected
        return mutableCopy
    }
}


class MKMapViewCoordinator: NSObject, MKMapViewDelegate {
    
    var mapViewPlanetEarth: PEMapView
    
    init(mapView: PEMapView) {
        self.mapViewPlanetEarth = mapView
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Artwork else { return nil }
        
        var annotationView: MarkerView
        if let markerView = mapView.dequeueReusableAnnotationView(
            withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MarkerView {
            markerView.annotation = annotation
            annotationView = markerView
        } else {
            annotationView = MarkerView(
                annotation: annotation,
                reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier
            )
            annotationView.animatesWhenAdded = true
        }
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let artwork = view.annotation as? Artwork {
            artwork.span = mapView.region.span
            let region = MKCoordinateRegion(center: artwork.coordinate, span: artwork.span)
            mapView.setRegion(region, animated: true)
            self.mapViewPlanetEarth.annotationSelectionChangedClosure?(artwork)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.mapViewPlanetEarth.selectedAnnotation = nil
        self.mapViewPlanetEarth.annotationSelectionChangedClosure?(nil)
    }
   
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        guard mapView.selectedAnnotations.isEmpty else { return }

        if let selectedAnnotation = self.mapViewPlanetEarth.selectedAnnotation {
            guard let annotation = mapView.annotations.first(where: { ($0 as? Artwork)?.id == selectedAnnotation.id })
            else {
                return
            }

            guard !mapView.selectedAnnotations.contains(where: { ($0 as? Artwork)?.id == selectedAnnotation.id })
            else {
                return
            }
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
}
