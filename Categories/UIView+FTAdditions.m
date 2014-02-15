@import QuartzCore;

#import "UIView+FTAdditions.h"

@implementation UIView (FTAdditions)

#pragma mark - Layout

- (CGFloat)xOrigin
{
	CGFloat xOrigin = self.center.x - (self.width / 2.0f);
	return xOrigin;
}

- (void)setXOrigin: (CGFloat)xOrigin
{
	CGPoint viewCenter = self.center;
	// floor the x origin to avoid subpixel rendering
	viewCenter.x = floor(xOrigin) + (self.width / 2.0f);
	self.center = viewCenter;
}

- (CGFloat)yOrigin
{
	CGFloat yOrigin = self.center.y - (self.height / 2.0f);
	return yOrigin;
}

- (void)setYOrigin: (CGFloat)yOrigin
{
	CGPoint viewCenter = self.center;
	// floor the y origin to avoid subpixel rendering
	viewCenter.y = floorf(yOrigin) + (self.height / 2.0f);
	self.center = viewCenter;
}

- (CGFloat)width
{
	CGFloat width = self.bounds.size.width;
	return width;
}

- (void)setWidth: (CGFloat)width
{
	// because changing the width of a view through its bounds updates the x origin we need to track the previous value and set it after the bounds have been changed
	CGFloat previousXOrigin = self.xOrigin;
	CGRect viewBounds = self.bounds;
	// floor the width to avoid subpixel rendering
	viewBounds.size.width = floorf(width);
	self.bounds = viewBounds;
	self.xOrigin = previousXOrigin;
}

- (CGFloat)height
{
	CGFloat height = self.bounds.size.height;
	return height;
}

- (void)setHeight: (CGFloat)height
{
	// because changing the height of a view through its bounds updates the y origin we need to track the previous value and set it after the bounds have been changed
	CGFloat previousYOrigin = self.yOrigin;
	CGRect viewBounds = self.bounds;
	// floor the height to avoid subpixel rendering
	viewBounds.size.height = floorf(height);
	self.bounds = viewBounds;
	self.yOrigin = previousYOrigin;
}

#pragma mark - Autolayout

+(instancetype)autoLayoutView
{
    UIView *viewToReturn = [self new];
    viewToReturn.translatesAutoresizingMaskIntoConstraints = NO;
    return viewToReturn;
}

/* Pinning */

-(NSLayoutConstraint *)pinEdge:(CYGUIViewEdgePin)edge toEdge:(CYGUIViewEdgePin)toEdge ofItem:(id)peerItem
{
    return [self pinEdge:edge toEdge:toEdge ofItem:peerItem inset:0.0];
}

-(NSLayoutConstraint *)pinEdge:(CYGUIViewEdgePin)edge toEdge:(CYGUIViewEdgePin)toEdge ofItem:(id)peerItem inset:(CGFloat)inset
{
    NSLayoutAttribute edgeAttribute, toEdgeAttribute;
    NSUInteger edgeCount = 0;
    NSUInteger toEdgeCount = 0;
  if (edge & CYGUIViewEdgePinTop) {
      edgeAttribute = NSLayoutAttributeTop;
      edgeCount++;
  }
    if (edge & CYGUIViewEdgePinLeft) {
    		edgeAttribute = NSLayoutAttributeLeft;
    		edgeCount++;
    }
    if (edge & CYGUIViewEdgePinRight) {
    		edgeAttribute = NSLayoutAttributeRight;
    		edgeCount++;
    }
    if (edge & CYGUIViewEdgePinBottom) {
    		edgeAttribute = NSLayoutAttributeBottom;
    		edgeCount++;
    }
	  if (toEdge & CYGUIViewEdgePinTop) {
	  	  toEdgeAttribute = NSLayoutAttributeTop;
	  	  toEdgeCount++;
	  }
    if (toEdge & CYGUIViewEdgePinLeft) {
    		toEdgeAttribute = NSLayoutAttributeLeft;
    		toEdgeCount++;
    }
    if (toEdge & CYGUIViewEdgePinRight) {
    		toEdgeAttribute = NSLayoutAttributeRight;
    		toEdgeCount++;
    }
    if (toEdge & CYGUIViewEdgePinBottom) {
    		toEdgeAttribute = NSLayoutAttributeBottom;
    		toEdgeCount++;
    }
    NSAssert (edgeCount == 1 && toEdgeCount == 1, @"Edge parameters must be a single edge.");
    return [self pinEdgeAttribute:edgeAttribute toEdgeAttribute:toEdgeAttribute ofItem:peerItem inset:inset];

}

-(NSArray *)pinEdges:(CYGUIViewEdgePin)edges toSameEdgesOfView:(UIView *)peerView
{
    return [self pinEdges:edges toSameEdgesOfView:peerView inset:0];
}
-(NSArray *)pinEdges:(CYGUIViewEdgePin)edges toSameEdgesOfView:(UIView *)peerView inset:(CGFloat)inset
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
    if (edges & CYGUIViewEdgePinTop) {
        [constraints addObject:[self pinEdgeAttribute:NSLayoutAttributeTop toEdgeAttribute:NSLayoutAttributeTop ofItem:peerView inset:inset]];
    }
    if (edges & CYGUIViewEdgePinLeft) {
        [constraints addObject:[self pinEdgeAttribute:NSLayoutAttributeLeft toEdgeAttribute:NSLayoutAttributeLeft ofItem:peerView inset:inset]];
    }
    if (edges & CYGUIViewEdgePinRight) {
        [constraints addObject:[self pinEdgeAttribute:NSLayoutAttributeRight toEdgeAttribute:NSLayoutAttributeRight ofItem:peerView inset:-inset]];
    }
    if (edges & CYGUIViewEdgePinBottom) {
        [constraints addObject:[self pinEdgeAttribute:NSLayoutAttributeBottom toEdgeAttribute:NSLayoutAttributeBottom ofItem:peerView inset:-inset]];
    }
    return [constraints copy];
}

-(NSArray*)pinEdges:(CYGUIViewEdgePin)edges toSuperViewWithInset:(CGFloat)inset;
{
	return [self pinEdges:edges toSuperViewWithInset:inset usingLayoutGuidesFrom:nil];
}

-(NSArray*)pinEdges:(CYGUIViewEdgePin)edges toSuperViewWithInset:(CGFloat)inset usingLayoutGuidesFrom:(UIViewController*)viewController
{
    UIView *superview = self.superview;
    NSAssert(superview,@"Can't pin to a superview if no superview exists");

    id topItem = nil;
    id bottomItem = nil;

#ifdef __IPHONE_7_0
    if (viewController && [viewController respondsToSelector:@selector(topLayoutGuide)]) {
        topItem = viewController.topLayoutGuide;
        bottomItem = viewController.bottomLayoutGuide;
    }
#endif

    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];

    if (edges & CYGUIViewEdgePinTop) {
        id item = topItem ? topItem : superview;
        NSLayoutAttribute attribute = topItem ? NSLayoutAttributeBottom : NSLayoutAttributeTop;
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:attribute multiplier:1.0 constant:inset]];
    }
    if (edges & CYGUIViewEdgePinLeft) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:inset]];
    }
    if (edges & CYGUIViewEdgePinRight) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:-inset]];
    }
    if (edges & CYGUIViewEdgePinBottom) {
        id item = bottomItem ? bottomItem : superview;
        NSLayoutAttribute attribute = bottomItem ? NSLayoutAttributeTop : NSLayoutAttributeBottom;
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:attribute multiplier:1.0 constant:-inset]];
    }
    [superview addConstraints:constraints];
    return [constraints copy];
}

- (NSLayoutConstraint *)pinEdgeAttribute:(NSLayoutAttribute)edge toEdgeAttribute:(NSLayoutAttribute)toEdge ofItem:(id)peerItem
{
    return [self pinEdgeAttribute:edge toEdgeAttribute:toEdge ofItem:peerItem inset:0.0];
}

- (NSLayoutConstraint *)pinEdgeAttribute:(NSLayoutAttribute)edge toEdgeAttribute:(NSLayoutAttribute)toEdge ofItem:(id)peerItem inset:(CGFloat)inset
{
    UIView *superview;
    if ([peerItem isKindOfClass:[UIView class]]) {
        superview = [self nearestCommonAncestor:peerItem];
        NSAssert(superview,@"Can't create constraints without a common ancestor");
    }
    else {
        superview = self.superview;
    }

    NSAssert (edge >= NSLayoutAttributeLeft && edge <= NSLayoutAttributeBottom,@"Edge parameter is not an edge");
    NSAssert (toEdge >= NSLayoutAttributeLeft && toEdge <= NSLayoutAttributeBottom,@"Edge parameter is not an edge");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:edge relatedBy:NSLayoutRelationEqual toItem:peerItem attribute:toEdge multiplier:1.0 constant:inset];
    [superview addConstraint:constraint];
    return constraint;
}

-(NSArray*)pinXAttribute:(NSLayoutAttribute)x YAttribute:(NSLayoutAttribute)y toPointInSuperview:(CGPoint)point
{
    UIView *superview = self.superview;
    NSAssert(superview,@"Can't create constraints without a superview");
    // Valid X positions are Left, Center, Right and Not An Attribute
    __unused BOOL xValid = (x == NSLayoutAttributeLeft || x == NSLayoutAttributeCenterX || x == NSLayoutAttributeRight || x == NSLayoutAttributeNotAnAttribute);
    // Valid Y positions are Top, Center, Baseline, Bottom and Not An Attribute
    __unused BOOL yValid = (y == NSLayoutAttributeTop || y == NSLayoutAttributeCenterY || y == NSLayoutAttributeBaseline || y == NSLayoutAttributeBottom || y == NSLayoutAttributeNotAnAttribute);

    NSAssert (xValid && yValid,@"Invalid positions for creating constraints");
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    if (x != NSLayoutAttributeNotAnAttribute) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:x relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:point.x];
        [constraints addObject:constraint];
    }
    if (y != NSLayoutAttributeNotAnAttribute) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:y relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:point.y];
        [constraints addObject:constraint];
    }
    [superview addConstraints:constraints];
    return [constraints copy];
}

/* Spacing */

// Centers the receiver in its container
-(NSArray *)centerInSuperview
{
    UIView *superview = self.superview;
    NSParameterAssert(superview);
    return [self centerInView:superview];
}

// Centers the receiver in the superview
-(NSArray *)centerInView:(UIView*)superview
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObject:[self centerInView:superview onAxis:NSLayoutAttributeCenterX]];
    [constraints addObject:[self centerInView:superview onAxis:NSLayoutAttributeCenterY]];
    return [constraints copy];
}

-(NSLayoutConstraint *)centerInView:(UIView*)superview onAxis:(NSLayoutAttribute)axis
{
    NSParameterAssert(axis == NSLayoutAttributeCenterX || axis == NSLayoutAttributeCenterY);
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:axis relatedBy:NSLayoutRelationEqual toItem:superview attribute:axis multiplier:1.0 constant:0.0];
    [superview addConstraint:constraint];
    return constraint;
}

-(void)spaceViews:(NSArray *)views onAxis:(UILayoutConstraintAxis)axis
{
    NSAssert([views count] > 1,@"Can only distribute 2 or more views");

    NSLayoutAttribute attributeForView;
    NSLayoutAttribute attributeToPin;

    switch (axis) {
        case UILayoutConstraintAxisHorizontal:
            attributeForView = NSLayoutAttributeCenterX;
            attributeToPin = NSLayoutAttributeRight;
            break;
        case UILayoutConstraintAxisVertical:
            attributeForView = NSLayoutAttributeCenterY;
            attributeToPin = NSLayoutAttributeBottom;
            break;
        default:
            return;
    }

    CGFloat fractionPerView = 1.0 / (CGFloat)([views count] + 1);
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        CGFloat multiplier = fractionPerView * (idx + 1.0);
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attributeForView relatedBy:NSLayoutRelationEqual toItem:self attribute:attributeToPin multiplier:multiplier constant:0.0]];
    }];
}

-(void)spaceViews:(NSArray*)views onAxis:(UILayoutConstraintAxis)axis withSpacing:(CGFloat)spacing alignmentOptions:(NSLayoutFormatOptions)options;
{
    NSAssert([views count] > 1,@"Can only distribute 2 or more views");
    NSString *direction = nil;
    switch (axis) {
        case UILayoutConstraintAxisHorizontal:
            direction = @"H:";
            break;
        case UILayoutConstraintAxisVertical:
            direction = @"V:";
            break;
        default:
            return;
    }

    UIView *previousView = nil;
    NSDictionary *metrics = @{@"spacing":@(spacing)};
    NSString *vfl = nil;
    for (UIView *view in views) {
        vfl = nil;
        NSDictionary *views = nil;
        if (previousView) {
            vfl = [NSString stringWithFormat:@"%@[previousView(==view)]-spacing-[view]",direction];
            views = NSDictionaryOfVariableBindings(previousView,view);
        }
        else {
            vfl = [NSString stringWithFormat:@"%@|-spacing-[view]",direction];
            views = NSDictionaryOfVariableBindings(view);
        }

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:options metrics:metrics views:views]];
        previousView = view;
    }
    vfl = [NSString stringWithFormat:@"%@[previousView]-spacing-|",direction];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:options metrics:metrics views:NSDictionaryOfVariableBindings(previousView)]];
}

/* Size constraints */

-(NSLayoutConstraint *)constrainToWidth:(CGFloat)width
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:width];
    [self addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *)constrainToHeight:(CGFloat)height
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:height];
    [self addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *)constrainToWidthOfView:(UIView *)peerView
{
	 	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:peerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *)constrainToHeightOfView:(UIView *)peerView
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:peerView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    return constraint;
}

-(NSArray *)constrainToSize:(CGSize)size
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    if (size.width) [constraints addObject:[self constrainToWidth:size.width]];
    if (size.height) [constraints addObject:[self constrainToHeight:size.height]];
    return [constraints copy];
}

-(NSArray *)constrainToMinimumSize:(CGSize)minimum
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    if (minimum.width)
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:0 multiplier:0 constant:minimum.width]];
    if (minimum.height)
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:0 multiplier:0 constant:minimum.height]];
    [self addConstraints:constraints];
    return [constraints copy];
}

-(NSArray *)constrainToMaximumSize:(CGSize)maximum
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    if (maximum.width)
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:0 multiplier:0 constant:maximum.width]];
    if (maximum.height)
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:0 multiplier:0 constant:maximum.height]];
    [self addConstraints:constraints];
    return [constraints copy];
}

-(NSArray *)constrainToMinimumSize:(CGSize)minimum maximumSize:(CGSize)maximum
{
    NSAssert(minimum.width <= maximum.width, @"maximum width should be strictly wider than or equal to minimum width");
    NSAssert(minimum.height <= maximum.height, @"maximum height should be strictly higher than or equal to minimum height");
    NSArray *minimumConstraints = [self constrainToMinimumSize:minimum];
    NSArray *maximumConstraints = [self constrainToMaximumSize:maximum];
    return [minimumConstraints arrayByAddingObjectsFromArray:maximumConstraints];
}

#pragma mark - Legacy layout

- (void)alignHorizontally:(CYGUIViewHorizontalAlignment)horizontalAlignment
{
	if (self.superview == nil) {
		return;
	}

	switch (horizontalAlignment) {
		case CYGUIViewHorizontalAlignmentCenter:
 		{
			self.xOrigin = (self.superview.width - self.width) / 2.0f;
			break;
		}
		case CYGUIViewHorizontalAlignmentLeft:
		{
			self.xOrigin = 0.0f;
			break;
		}
		case CYGUIViewHorizontalAlignmentRight:
		{
			self.xOrigin = self.superview.width - self.width;
			break;
		}
	}
}

- (void)alignVertically: (CYGUIViewVerticalAlignment)verticalAlignment
{
	if (self.superview == nil) {
		return;
	}

	switch (verticalAlignment) {
		case CYGUIViewVerticalAlignmentMiddle:
		{
			self.yOrigin = (self.superview.height - self.height) / 2.0f;
			break;
		}
		case CYGUIViewVerticalAlignmentTop:
		{
			self.yOrigin = 0.0;
			break;
		}
		case CYGUIViewVerticalAlignmentBottom:
		{
			self.yOrigin = self.superview.height - self.height;
			break;
		}
	}
}

- (void)alignHorizontally: (CYGUIViewHorizontalAlignment)horizontalAlignment
               vertically: (CYGUIViewVerticalAlignment)verticalAlignment
{
	[self alignHorizontally: horizontalAlignment];
	[self alignVertically: verticalAlignment];
}

#pragma mark - Util

- (void)removeAllSubviews
{
	[self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
}

- (NSArray *) superviews
{
    NSMutableArray *array = [NSMutableArray array];
    UIView *view = self.superview;
    while (view) {
        [array addObject:view];
        view = view.superview;
    }
    return array;
}

- (NSArray *) allSubviews
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        [array addObject:view];
        [array addObjectsFromArray:[view allSubviews]];
    }
    return array;
}

- (BOOL)isAncestorOf:(UIView *)aView
{
    return [aView.superviews containsObject:self];
}

- (UIView *)nearestCommonAncestor:(UIView *)aView
{
    // Check for same view
    if (self == aView)
        return self;

    // Check for direct superview relationship
    if ([self isAncestorOf:aView])
        return self;
    if ([aView isAncestorOf:self])
        return aView;

    // Search for indirect common ancestor
    NSArray *ancestors = self.superviews;
    for (UIView *view in aView.superviews)
        if ([ancestors containsObject:view])
            return view;

    // No common ancestor
    return nil;
}

#pragma mark - Animation

+ (void)animateIf: (BOOL)condition
         duration: (NSTimeInterval)duration
            delay: (NSTimeInterval)delay
          options: (UIViewAnimationOptions)options
       animations: (void (^)(void))animations
       completion: (void (^)(BOOL finished))completion
{
	if (condition == YES) {
		[UIView animateWithDuration: duration
			delay: delay
			options: options
			animations: animations
			completion: completion];
	}
	else {
		if (animations != nil) {
			animations();
		}

		if (completion != nil) {
			completion(NO);
		}
	}
}

@end
