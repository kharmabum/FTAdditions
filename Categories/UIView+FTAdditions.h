@import Foundation;
@import UIKit;

/* Autolayout */

typedef NS_OPTIONS(unsigned long, CYGUIViewEdgePin){
    CYGUIViewEdgePinTop= 1 << 0,
    CYGUIViewEdgePinRight= 1 << 1,
    CYGUIViewEdgePinBottom= 1 << 2,
    CYGUIViewEdgePinLeft= 1 << 3,
    CYGUIViewEdgePinAll = ~0UL
};

/* Legacy layout */

typedef NS_ENUM(NSUInteger, CYGUIViewHorizontalAlignment) {
  CYGUIViewHorizontalAlignmentCenter = 0,
  CYGUIViewHorizontalAlignmentLeft = 1,
  CYGUIViewHorizontalAlignmentRight = 2
};

typedef NS_ENUM(NSUInteger, CYGUIViewVerticalAlignment) {
  CYGUIViewVerticalAlignmentMiddle = 0,
  CYGUIViewVerticalAlignmentTop = 1,
  CYGUIViewVerticalAlignmentBottom = 2
};


@interface UIView (FTAdditions)

@property (nonatomic, assign) CGFloat xOrigin;
@property (nonatomic, assign) CGFloat yOrigin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

#pragma mark - Autolayout

+(instancetype)autoLayoutView;

/* Pinning */

/// Pins a view's edge to a peer item's edge. The item may be the layout guide of a view controller
-(NSLayoutConstraint *)pinEdge:(CYGUIViewEdgePin)edge toEdge:(CYGUIViewEdgePin)toEdge ofItem:(id)peerItem;
-(NSLayoutConstraint *)pinEdge:(CYGUIViewEdgePin)edge toEdge:(CYGUIViewEdgePin)toEdge ofItem:(id)peerItem inset:(CGFloat)inset;


/// Pins a views edge(s) to another views edge(s). Both views must be in the same view hierarchy.
-(NSArray *)pinEdges:(CYGUIViewEdgePin)edges toSameEdgesOfView:(UIView *)peerView;
-(NSArray *)pinEdges:(CYGUIViewEdgePin)edges toSameEdgesOfView:(UIView *)peerView inset:(CGFloat)inset;

/// Pins a view to a specific edge(s) of its superview, with a specified inset
-(NSArray*)pinEdges:(CYGUIViewEdgePin)edges toSuperViewWithInset:(CGFloat)inset;
-(NSArray*)pinEdges:(CYGUIViewEdgePin)edges toSuperViewWithInset:(CGFloat)inset usingLayoutGuidesFrom:(UIViewController*)viewController;

// Pins a point to a specific point in the superview's frame. Use NSLayoutAttributeNotAnAttribute to only pin in one dimension
-(NSArray*)pinXAttribute:(NSLayoutAttribute)x YAttribute:(NSLayoutAttribute)y toPointInSuperview:(CGPoint)point;

/* Spacing */

// Centers the receiver in the superview
-(NSArray *)centerInSuperview;
-(NSArray *)centerInView:(UIView*)superview;
-(NSLayoutConstraint *)centerInView:(UIView*)superview onAxis:(NSLayoutAttribute)axis;

// Spaces the views evenly along the selected axis, using their intrinsic size
-(void)spaceViews:(NSArray*)views onAxis:(UILayoutConstraintAxis)axis;

// Spaces the views evenly along the selected axis. Will force the views to the same size to make them fit
-(void)spaceViews:(NSArray*)views onAxis:(UILayoutConstraintAxis)axis withSpacing:(CGFloat)spacing alignmentOptions:(NSLayoutFormatOptions)options;


/* Size constraints */

// Set to a specific width or height.
-(NSLayoutConstraint *)constrainToWidth:(CGFloat)width;
-(NSLayoutConstraint *)constrainToHeight:(CGFloat)height;

// Set an equal width or height
-(NSLayoutConstraint *)constrainToWidthOfView:(UIView *)peerView;
-(NSLayoutConstraint *)constrainToHeightOfView:(UIView *)peerView;

/// Set to a specific size. 0 in any axis results in no constraint being applied.
-(NSArray *)constrainToSize:(CGSize)size;

// Set a minimum size. 0 in any axis results in no constraint being applied.
-(NSArray *)constrainToMinimumSize:(CGSize)minimum;

// Set a maximum size. 0 in any axis results in no constraint being applied.
-(NSArray *)constrainToMaximumSize:(CGSize)maximum;

// Set minimum and maximum sizes. 0 in any axis results in no constraint in that direction. (e.g. 0 maximumHeight means no max height)
-(NSArray *)constrainToMinimumSize:(CGSize)minimum maximumSize:(CGSize)maximum;

#pragma mark - Legacy layout

- (void)alignHorizontally:(CYGUIViewHorizontalAlignment)horizontalAlignment;
- (void)alignVertically:(CYGUIViewVerticalAlignment)verticalAlignment;
- (void)alignHorizontally:(CYGUIViewHorizontalAlignment)horizontalAlignment
               vertically:(CYGUIViewVerticalAlignment)verticalAlignment;

#pragma mark - Util

- (void)removeAllSubviews;
- (NSArray *)superviews;
- (NSArray *)allSubviews;
- (BOOL)isAncestorOf:(UIView *)aView;
- (UIView *)nearestCommonAncestor:(UIView *)aView;

#pragma mark - Animation

+ (void)animateIf: (BOOL)condition
         duration: (NSTimeInterval)duration
            delay: (NSTimeInterval)delay
          options: (UIViewAnimationOptions)options
       animations: (void (^)(void))animations
       completion: (void (^)(BOOL finished))completion;

@end
