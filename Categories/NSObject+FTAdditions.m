#import "NSObject+PerformBlock.h"

@implementation NSObject (FTAdditions)


- (void)performBlock: (dispatch_block_t)block
          afterDelay: (NSTimeInterval)delay
{
	[self performSelector: @selector(_callBlock:)
               withObject: block
               afterDelay: delay];
}

- (void)performBlockOnMainThread: (dispatch_block_t)block
{
	dispatch_sync(
                  dispatch_get_main_queue(),
                  block);
}


- (void)performBlockOnMainThread: (dispatch_block_t)block
                      afterDelay: (NSTimeInterval)delay
{
    dispatch_time_t dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
	dispatch_after(dispatchTime, dispatch_get_main_queue(), block);
}

- (void)performBlockInBackground: (dispatch_block_t)block
{
	dispatch_queue_t globalQueue = dispatch_get_global_queue(
                                                             DISPATCH_QUEUE_PRIORITY_BACKGROUND,
                                                             0);
    
	dispatch_async(
                   globalQueue, 
                   block);
}


#pragma mark - Private Methods

- (void)_callBlock: (dispatch_block_t)block
{
	block();
}

#pragma mark - Class Methods

+ (void) swizzleInstanceSelector:(SEL)originalSelector
                 withNewSelector:(SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    BOOL methodAdded = class_addMethod([self class],
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end