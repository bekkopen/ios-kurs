#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

+ (NSDate *)dateFromZuluTimeString:(NSString *)string
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    return [df dateFromString:string];
}

@end
