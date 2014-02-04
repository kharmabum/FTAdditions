#import "UIImage+FTAdditions.h"

@implementation UIImage (FTAdditions)

- (UIColor *)averageColor{
    if(!self){
        return nil;
    }
    
    CGImageRef imageRef = [self CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    NSUInteger bitsMultiplier = CGImageGetBitsPerPixel(imageRef)/8;
    
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    NSData *data = CFBridgingRelease(CGDataProviderCopyData(provider));
    const uint8_t *bytes = [data bytes];
    
    NSUInteger colorCount = 0;
    CGFloat red = 0, green = 0, blue = 0;
    
    NSUInteger x = 0, y = 0;
    NSUInteger xOffset = 2, yOffset = 2;
    while(x < width){
        while(y < height){
            NSUInteger pixelIndex = (y*width+x)*bitsMultiplier;
            red += bytes[pixelIndex];
            green += bytes[pixelIndex+1];
            blue += bytes[pixelIndex+2];
            colorCount++;
            y += yOffset;
        }
        x += xOffset;
        y = 0;
    }
    
    CGFloat averageRed = red/colorCount;
    CGFloat averageGreen = green/colorCount;
    CGFloat averageBlue = blue/colorCount;
    
    return [UIColor colorWithRed:averageRed/255 green:averageGreen/255 blue:averageBlue/255 alpha:1];
}

+ (UIImage *)imageFromDiskNamed:(NSString *)imageName {
    NSRange r = [imageName rangeOfString:@"."];
    NSString *fileName = imageName;
    NSString *fileType = @"png"; //default
    if (r.location != NSNotFound) {
        fileName = [imageName substringToIndex:r.location];
        fileType = [imageName substringFromIndex:(r.location + 1)];
    }
    CGFloat scale = 1.0;
    UIScreen *screen = [UIScreen mainScreen];
    if ([screen respondsToSelector:@selector(scale)]) {
        scale = screen.scale;
    }
    if (scale == 2.0) {
        fileName = [fileName stringByAppendingString:@"@2x"];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    return [[UIImage alloc] initWithContentsOfFile:path];
}

@end
