@import Foundation;

@interface NSObject (FTAdditions)

- (void)performBlock: (dispatch_block_t)block
          afterDelay: (NSTimeInterval)delay;

- (void)performBlockOnMainThread: (dispatch_block_t)block;

- (void)performBlockOnMainThread: (dispatch_block_t)block
                      afterDelay: (NSTimeInterval)delay;

- (void)performBlockInBackground: (dispatch_block_t)block;

+ (void)swizzleInstanceSelector:(SEL)originalSelector
                withNewSelector:(SEL)newSelector;

@end
