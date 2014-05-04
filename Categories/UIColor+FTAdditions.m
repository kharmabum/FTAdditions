#import "UIColor+FTAdditions.h"
#import <SAMCategories.h>


@implementation UIColor (FTAdditions)

#pragma mark - Components

- (CGFloat)alphaComponent{
    return CGColorGetAlpha([self CGColor]);
}

- (UIColor *)colorWithoutAlpha{
    return [UIColor colorWithColor:self andAlpha:1];
}

+ (UIColor *)colorWithColor:(UIColor *)color andAlpha:(CGFloat)alpha{
    NSArray *component = [color componentArray];
    return [UIColor colorWithRed:[component[0] doubleValue] green:[component[1] doubleValue] blue:[component[2] doubleValue] alpha:alpha];
}

- (NSArray *)componentArray{
    CGFloat red, green, blue, alpha;
    const CGFloat *components = CGColorGetComponents([self CGColor]);
    if(CGColorGetNumberOfComponents([self CGColor]) == 2){
        red = components[0];
        green = components[0];
        blue = components[0];
        alpha = components[1];
    }else{
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    return @[@(red), @(green), @(blue), @(alpha)];
}

#pragma mark - Color


- (UIColor *)invertedColor{
    NSArray *components = [self componentArray];
    return [UIColor colorWithRed:1-[components[0] doubleValue] green:1-[components[1] doubleValue] blue:1-[components[2] doubleValue] alpha:[components[3] doubleValue]];
}

- (UIColor *)colorForTranslucency{
    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:saturation*1.158 brightness:brightness*0.95 alpha:alpha];
}

- (UIColor *)lightenColor:(CGFloat)lighten{
    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:saturation*(1-lighten) brightness:brightness*(1+lighten) alpha:alpha];
}

- (UIColor *)darkenColor:(CGFloat)darken{
    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:saturation*(1+darken) brightness:brightness*(1-darken) alpha:alpha];
}

#pragma mark - Defaults

+ (UIColor *)ft_orangeColor
{
    return [UIColor sam_colorWithHex:@"0xFFBB00"];
}

+ (UIColor *)ft_greenColor
{
    return [UIColor sam_colorWithHex:@"0x00FF91"];
}

+ (UIColor *)ft_blueColor
{
    return [UIColor sam_colorWithHex:@"0x00C4FF"];
}

+ (UIColor *)ft_redColor
{
    return [UIColor sam_colorWithHex:@"0xFF0045"];
}

@end
