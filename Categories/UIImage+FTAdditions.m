#import "UIImage+FTAdditions.h"

@implementation UIImage (FTAdditions)

+ (UIImage *)circleImageWithSize:(int)size color:(UIColor *)color
{
    if (!color) color = [UIColor colorWithWhite:0.9 alpha:1];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size, size)];
    CGContextAddPath(context, circle.CGPath);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathFill);
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage *)bottomImage overlaidWithImage:(UIImage *)topImage
{
    NSUInteger maxW = MAX(bottomImage.size.width, topImage.size.width);
    NSUInteger maxH = MAX(bottomImage.size.height, topImage.size.height);
    CGSize size = CGSizeMake(maxW, maxH);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [bottomImage drawAtPoint:CGPointZero];
    CGPoint centerAlignedPoint = CGPointMake(maxW/2 - topImage.size.width/2, maxH/2 - topImage.size.height/2);
    [topImage drawAtPoint:centerAlignedPoint];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIColor *)averageColor
{
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

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
