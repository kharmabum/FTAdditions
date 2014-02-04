#import <Foundation/Foundation.h>

@interface UIImage (FTAdditions) 

- (UIColor *)averageColor;
+ (UIImage *)imageFromDiskNamed:(NSString *)imageName;

@end
