#import "NSURLRequest+FTAdditions.h"

@implementation NSURLRequest (FTAdditions)
- (void) logDebugData {
	NSLog(@"Method: %@", self.HTTPMethod);
	NSLog(@"URL: %@", self.URL.absoluteString);
	NSLog(@"Body: %@", [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding]);
}

@end
