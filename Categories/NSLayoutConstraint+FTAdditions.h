@import Foundation;
@import UIKit;

@interface NSLayoutConstraint (FTAdditions)

@property (nonatomic, readonly) UIView *firstView;
@property (nonatomic, readonly) UIView *secondView;
@property (nonatomic, readonly) BOOL isUnary;
@property (nonatomic, readonly) UIView *likelyOwner;

- (BOOL) install;
- (BOOL) install: (float) priority;
- (void) remove;

+ (NSString *) nameForLayoutAttribute: (NSLayoutAttribute) anAttribute;
+ (NSString *) nameForFormatOption: (NSLayoutFormatOptions) anOption;
+ (NSString *) nameForLayoutRelation: (NSLayoutRelation) aRelation;

@end
