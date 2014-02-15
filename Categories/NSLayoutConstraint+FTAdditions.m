#import "NSLayoutConstraint+FTAdditions.h"
#import "UIView+FTAdditions.h"

#ifndef UIViewNoIntrinsicMetric
#define UIViewNoIntrinsicMetric -1
#endif

#define IS_LEADING_ATTRIBUTE(_ATTRIBUTE_) [@[@(NSLayoutAttributeTop), @(NSLayoutAttributeLeading), @(NSLayoutAttributeLeft)] containsObject:@(_ATTRIBUTE_)]
#define IS_TRAILING_ATTRIBUTE(_ATTRIBUTE_) [@[@(NSLayoutAttributeBottom), @(NSLayoutAttributeTrailing), @(NSLayoutAttributeRight)] containsObject:@(_ATTRIBUTE_)]
#define IS_UNSUPPORTED_ATTRIBUTE(_ATTRIBUTE_) [@[@(NSLayoutAttributeLeft), @(NSLayoutAttributeRight), @(NSLayoutAttributeBaseline)] containsObject:@(_ATTRIBUTE_)]


@implementation NSLayoutConstraint (FTAdditions)

// Cast the first item to a view
- (UIView *)firstView
{
    return self.firstItem;
}

// Cast the second item to a view
- (UIView *)secondView
{
    return self.secondItem;
}

// Are two items involved or not
- (BOOL)isUnary
{
    return self.secondItem == nil;
}

// Return NCA
- (UIView *)likelyOwner
{
    if (self.isUnary)
        return self.firstView;

    return [self.firstView nearestCommonAncestor:self.secondView];
}

- (BOOL) install
{
    // Handle Unary constraint
    if (self.isUnary) {
        // Add weak owner reference
        [self.firstView addConstraint:self];
        return YES;
    }

    // Install onto nearest common ancestor
    UIView *view = [self.firstView nearestCommonAncestor:self.secondView];
    if (!view) {
        NSLog(@"Error: Constraint cannot be installed. No common ancestor between items.");
        return NO;
    }

    [view addConstraint:self];
    return YES;
}

// Set priority and install
- (BOOL) install: (float) priority
{
    self.priority = priority;
    return [self install];
}

- (void) remove
{
    if (![self.class isEqual:[NSLayoutConstraint class]]) {
        NSLog(@"Error: Can only uninstall NSLayoutConstraint. %@ is an invalid class.", self.class.description);
        return;
    }

    if (self.isUnary) {
        UIView *view = self.firstView;
        [view removeConstraint:self];
        return;
    }

    // Remove from preferred recipient
    UIView *view = [self.firstView nearestCommonAncestor:self.secondView];
    if (!view) return;

    // If the constraint not on view, this is a no-op
    [view removeConstraint:self];
}

// Transform the attribute to a string
+ (NSString *) nameForLayoutAttribute: (NSLayoutAttribute) anAttribute
{
    switch (anAttribute)
    {
        case NSLayoutAttributeLeft: return @"left";
        case NSLayoutAttributeRight: return @"right";
        case NSLayoutAttributeTop: return @"top";
        case NSLayoutAttributeBottom: return @"bottom";
        case NSLayoutAttributeLeading: return @"leading";
        case NSLayoutAttributeTrailing: return @"trailing";
        case NSLayoutAttributeWidth: return @"width";
        case NSLayoutAttributeHeight: return @"height";
        case NSLayoutAttributeCenterX: return @"centerX";
        case NSLayoutAttributeCenterY: return @"centerY";
        case NSLayoutAttributeBaseline: return @"baseline";
        case NSLayoutAttributeNotAnAttribute:
        default: return @"not-an-attribute";
    }
}

// Transform the attribute to a string
+ (NSString *) nameForFormatOption:(NSLayoutFormatOptions)anOption
{
    NSLayoutFormatOptions option = anOption & NSLayoutFormatAlignmentMask;
    switch (option)
    {
        case NSLayoutFormatAlignAllLeft: return @"Left Alignment";
        case NSLayoutFormatAlignAllRight: return @"Right Alignment";
        case NSLayoutFormatAlignAllTop: return @"Top Alignment";
        case NSLayoutFormatAlignAllBottom: return @"Bottom Alignment";
        case NSLayoutFormatAlignAllLeading: return @"Leading Alignment";
        case NSLayoutFormatAlignAllTrailing: return @"Trailing Alignment";
        case NSLayoutFormatAlignAllCenterX: return @"CenterX Alignment";
        case NSLayoutFormatAlignAllCenterY: return @"CenterY Alignment";
        case NSLayoutFormatAlignAllBaseline: return @"Baseline Alignment";
        default:
            break;
    }

    option = anOption & NSLayoutFormatDirectionMask;
    switch (option)
    {
        case NSLayoutFormatDirectionLeadingToTrailing:
            return @"Leading to Trailing";
        case NSLayoutFormatDirectionLeftToRight:
            return @"Left to Right";
        case NSLayoutFormatDirectionRightToLeft:
            return @"Right to Left";
        default:
            return @"Unknown Format Option";
    }
}


// Transform the relation to a string
+ (NSString *) nameForLayoutRelation: (NSLayoutRelation) aRelation
{
    switch (aRelation)
    {
        case NSLayoutRelationLessThanOrEqual: return @"<=";
        case NSLayoutRelationEqual: return @"==";
        case NSLayoutRelationGreaterThanOrEqual: return @">=";
        default: return @"not-a-relation";
    }
}


@end
