#import "MKMapView+FTAdditions.h"
#import "FTDefines.h"

@implementation MKMapView (FTAdditions)

- (void)centerMapOnUserLocation
{
    CLLocation *location = self.userLocation.location;
    if (location) {
        [self setCenterCoordinate:location.coordinate animated:YES];
    }
}

- (void)zoomToFitAnnotationsWithUserLocation:(BOOL)fitToUserLocation
{
    if([self.annotations count] > 1) {
        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in self.annotations) {
            if(fitToUserLocation) {
                MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
                MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.2, 0.2);
                if (MKMapRectIsNull(zoomRect)) {
                    zoomRect = pointRect;
                } else {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect);
                }
            } else {
                if (![annotation isKindOfClass:[MKUserLocation class]] ) {
                    MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
                    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.2, 0.2);
                    if (MKMapRectIsNull(zoomRect)) {
                        zoomRect = pointRect;
                    } else {
                        zoomRect = MKMapRectUnion(zoomRect, pointRect);
                    }
                }
            }
        }

        zoomRect = MKMapRectMake(zoomRect.origin.x - (zoomRect.size.width*0.2)/2, zoomRect.origin.y - (zoomRect.size.height*0.4)/1.3, zoomRect.size.width*1.2, zoomRect.size.height*1.4);
        [self setVisibleMapRect:zoomRect animated:YES];
    }
}

- (void)focusOnCoordinate:(CLLocationCoordinate2D)coordinate withBufferDistance:(CLLocationDistance)buffer animated:(BOOL)animated
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude),
                                                                   buffer,
                                                                   buffer);
    [self setRegion:region animated:animated];
}


@end

