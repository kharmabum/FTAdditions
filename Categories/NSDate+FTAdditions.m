#import "NSDate+FTAdditions.h"

@implementation NSDate (FTAdditions)

- (NSDate *)startOfHour
{
  NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
  NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit);
  return [calendar dateFromComponents:[calendar components:preservedComponents fromDate:self]];
}

- (NSDate *)startOfDay
{
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSDate *midnight = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:self]];
    return midnight;
}

- (NSDate *)normalizedDay
{
  NSDate *midnight = [self startOfDay];
  if([[NSTimeZone localTimeZone] isDaylightSavingTimeForDate:midnight]) {
    midnight = [midnight dateByAddingTimeInterval:60*60];
  }
  return midnight;
}

- (NSDate *)startOfMonth
{
  NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
  NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit);
  return [calendar dateFromComponents:[calendar components:preservedComponents fromDate:self]];
}

@end
