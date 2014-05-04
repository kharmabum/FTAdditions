@import Foundation;
@import CoreLocation;
@import MapKit;

@interface MKMapView (FTAdditions)

- (void)centerMapOnUserLocation;

- (void)zoomToFitAnnotationsWithUserLocation:(BOOL)fitToUserLocation;

- (void)focusOnCoordinate:(CLLocationCoordinate2D)coordinate withBufferDistance:(CLLocationDistance)buffer animated:(BOOL)animated;

@end
