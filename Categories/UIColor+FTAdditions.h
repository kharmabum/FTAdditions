//
//  UIColor+FTAdditions.h
//  FTStarterApplication
//
//  Created by IO on 2/3/14.
//  Copyright (c) 2014 Fototropik. All rights reserved.
//

#import <UIKit/UIKit.h>

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
