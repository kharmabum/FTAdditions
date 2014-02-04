//
//  FTUI.m
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#import "FTUI.h"

static NSMutableDictionary *_fontsByNameAndSize = nil;
static NSMutableDictionary *_colorsByHex = nil;

@implementation FTUI

+ (UIFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    if (!_fontsByNameAndSize) _fontsByNameAndSize = [NSMutableDictionary dictionary];
        
    NSString *key = [NSString stringWithFormat:@"%@-%f", fontName, fontSize];
    UIFont *font = [_fontsByNameAndSize objectForKey:key];
    
    if (!font) {
        font = [UIFont fontWithName:fontName size:fontSize];
        [_fontsByNameAndSize setObject:font forKey:key];
    }
    
    return font;
}

+ (void)clearFontCache
{
    _fontsByNameAndSize = nil;
}

+ (UIColor *)colorFromHex:(int)colorInHex alpha:(CGFloat)alpha
{
    if (!_colorsByHex) _colorsByHex = [NSMutableDictionary dictionary];
    
    NSString *key = [NSString stringWithFormat:@"%x", colorInHex];
    UIColor *color = [_colorsByHex objectForKey:key];
    
    if (!color) {
        float red = (float) ((colorInHex & 0xFF0000) >> 16) / 255.0f;
        float green = (float) ((colorInHex & 0x00FF00) >> 8) / 255.0f;
        float blue = (float) ((colorInHex & 0x000FF) >> 0) / 255.0f;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [_colorsByHex setObject:color forKey:key];
    }
    
    return color;
}

+ (UIColor *)colorFromHex:(int)colorInHex
{
    return [FTUI colorFromHex:colorInHex alpha:1.0];
}

+ (void)clearColorCache
{
    _colorsByHex = nil;
}

+ (NSString *)ordinalSuffixFromNumber:(NSUInteger)n
{
    if (n == 11 || n == 12 || n == 13)
    {
        return @"th";
    }
    
    n = n % 10;
    
    switch (n) {
        case 1:
            return @"st";
            
        case 2:
            return @"nd";
            
        case 3:
            return @"rd";
            
        default:
            return @"th";
    }
}

@end
