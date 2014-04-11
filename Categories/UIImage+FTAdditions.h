@import Foundation;
@import UIKit;

@interface UIImage (FTAdditions)

+ (UIImage *)circleImageWithSize:(int)size color:(UIColor *)color;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithImage:(UIImage *)bottomImage overlaidWithImage:(UIImage *)topImage;

- (UIColor *)averageColor;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
- (UIImage *)overlayWithImage:(UIImage *)image;

@end
