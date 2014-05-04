#import <Foundation/Foundation.h>

@interface NSString (FTAdditions)

#pragma mark - Trimming

- (NSString *)stringByTrimmingLeadingAndTrailingCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingLeadingAndTrailingWhitespaceAndNewlineCharacters;

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;

- (BOOL)isAlphaNumeric;

@end
