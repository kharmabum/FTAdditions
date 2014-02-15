@import Foundation;
@import UIKit;

@interface UIColor (FTAdditions)

#pragma mark - Components

+ (UIColor *)colorWithColor:(UIColor *)color andAlpha:(CGFloat)alpha;

- (CGFloat)alphaComponent;
- (UIColor *)colorWithoutAlpha;
- (NSArray *)componentArray;

#pragma mark - Color

- (UIColor *)invertedColor;
- (UIColor *)colorForTranslucency;

- (UIColor *)lightenColor:(CGFloat)lighten;
- (UIColor *)darkenColor:(CGFloat)darken;

@end
