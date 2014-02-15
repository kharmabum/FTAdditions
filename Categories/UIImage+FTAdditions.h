@import Foundation;
@import UIKit;

@interface UIImage (FTAdditions)

- (UIColor *)averageColor;
+ (UIImage *)imageFromDiskNamed:(NSString *)imageName;

@end
