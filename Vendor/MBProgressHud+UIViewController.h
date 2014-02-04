#import <UIKit/UIKit.h>

@class MBProgressHUD

@interface UIView (UIViewWithMBProgressHUD)

- (void)hideHUD;

@end

@interface UIViewController (UIViewControllerWithMBProgressHUD) <MBProgressHUDDelegate>

- (void)showHUD;
- (void)showHUDWithText:(NSString*)text;
- (void)hideHUD;
- (BOOL)isHUDHidden;
- (void)show:(MBProgressHUD*)hud;

@end
