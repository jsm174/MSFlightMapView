//
//  MSFlight.swift
//  MSFlightMapView
//
//  Created by Muhammad Abdul Subhan on 03/12/2018.
//  Copyright © 2018 Subhan. All rights reserved.
//

import UIKit
import CoreLocation

public struct MSFlight {
    var firstLocation: CLLocationCoordinate2D
    var secondLocation: CLLocationCoordinate2D
    var iconImage: UIImage?
    var iconColor: UIColor?
    var pathColor: UIColor?
    var firstMarkerColor: UIColor?
    var secondMarkerColor: UIColor?
    
    public init(withFirstLocation firstLocation: CLLocationCoordinate2D, withSecondLocation secondLocation: CLLocationCoordinate2D, andIconImage iconImage: UIImage? = nil, andIconColor iconColor: UIColor? = nil, andPathColor pathColor: UIColor? = nil, andFirstMarkerColor firstMarkerColor: UIColor? = nil, andSecondMarkerColor secondMarkerColor: UIColor? = nil) {
        self.firstLocation = firstLocation
        self.secondLocation = secondLocation
        self.iconColor = iconColor
        self.iconImage = iconImage
        self.pathColor = pathColor
        self.firstMarkerColor = firstMarkerColor
        self.secondMarkerColor = secondMarkerColor
    }
}

extension MSFlight {
    func connecting(toLocation location: CLLocationCoordinate2D, andIconImage iconImage: UIImage? = nil, andIconColor iconColor: UIColor? = nil, andPathColor pathColor: UIColor? = nil, andFirstMarkerColor firstMarkerColor: UIColor? = nil, andSecondMarkerColor secondMarkerColor: UIColor? = nil) -> [MSFlight] {
        let secondFlight = MSFlight(withFirstLocation: self.secondLocation, withSecondLocation: location, andIconImage: iconImage, andIconColor: iconColor, andPathColor: pathColor, andFirstMarkerColor: firstMarkerColor, andSecondMarkerColor: secondMarkerColor)
        return [self, secondFlight]
    }
}

extension Array where Element == MSFlight {
    func connecting(toLocation location: CLLocationCoordinate2D, andIconImage iconImage: UIImage? = nil, andIconColor iconColor: UIColor? = nil, andPathColor pathColor: UIColor? = nil, andFirstMarkerColor firstMarkerColor: UIColor? = nil, andSecondMarkerColor secondMarkerColor: UIColor? = nil) -> [MSFlight] {
        var flights = self
        if let lastFlight = self.last {
            let newFlight = MSFlight(withFirstLocation: lastFlight.secondLocation, withSecondLocation: location, andIconImage: iconImage, andIconColor: iconColor, andPathColor: pathColor, andFirstMarkerColor: firstMarkerColor, andSecondMarkerColor: secondMarkerColor)
            flights.append(newFlight)
        }
        return flights
    }
}

public struct MSMultiLegFlight {
    public var flights: [MSFlight]
    
    public init(withLocations locations: [CLLocationCoordinate2D]) {
        flights = []
        if locations.count >= 2 {
            for index in 0..<locations.count-1 {
                flights.append(MSFlight(withFirstLocation: locations[index], withSecondLocation: locations[index+1]))
            }
        }
    }
}
