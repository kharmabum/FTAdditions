#import "CLLocation+FTAdditions.h"
#import "FTDefines.h"

@implementation CLLocation (FTAdditions)

+ (NSString *)convertDistanceToString:(double)distance
{
    BOOL isMetric = [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.maximumFractionDigits = 2;

    NSString *format;

    if (isMetric) {
        if (distance < kFTMetersCutoff) {
            format = @"%@ m";
        } else {
            format = @"%@ km";
            distance = distance / 1000;
        }
    } else {
        distance = distance * kFTMetersToFeet;
        if (distance < kFTFeetCutoff) {
            format = @"%@ ft";
        } else {
            format = @"%@ mi";
            distance = distance / kFTMilesToFeet;
        }
    }
    return [NSString stringWithFormat:format, [numberFormatter stringFromNumber:@(distance)]];
}

@end

