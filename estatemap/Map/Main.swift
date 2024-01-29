//
//  Main.swift
//  estatemap
//
//  Created by  User on 9/28/23.
//

import SwiftUI
import MicrosoftMaps
import CoreLocation
struct Main: View {
    var body: some View {
        BingMapView()
     }
}
struct BingMapView: UIViewRepresentable{
    var mapView = MSMapView()
    let LOCATION_LAKE_WASHINGTON = MSGeopoint(latitude: 47.609466, longitude: -122.265185)
     
    
    func makeUIView(context: Context) -> some UIView {
              
        mapView.credentialsKey = "AjumCSSqZVZXlkSDNt1rOMF8-lJMu48PzdOtSq4gil7wDGXVW_ccJ1eJIcX63Q4v"
        let scene = MSMapScene(location: LOCATION_LAKE_WASHINGTON, zoomLevel: 10)
        self.mapView.setScene(scene, with: .none)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
       
    }
    
}
struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
