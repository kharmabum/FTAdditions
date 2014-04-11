@import Foundation;

@interface NSDate (FTAdditions)

- (NSDate *)startOfHour;
- (NSDate *)startOfDay;
- (NSDate *)startOfMonth;

// Normalized day can be compared accross timezones (regardless of DST)
- (NSDate *)normalizedDay; // daylight savings time

@end
