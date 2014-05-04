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

#pragma mark - Defaults

+ (UIColor *)ft_orangeColor;
+ (UIColor *)ft_greenColor;
+ (UIColor *)ft_blueColor;
+ (UIColor *)ft_redColor;

@end
