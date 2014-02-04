#import "NSArray+FTAdditions.h"

@implementation NSArray (FTAdditions)

- (id)tryObjectAtIndex: (NSUInteger)index
{
	id object = nil;
	if (index < [self count]) {
		object = [self objectAtIndex: index];
	}
	return object;
}

@end
