//
//  Common.m
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import "Common.h"
#import "NSDate+TimeAgo.h"

@implementation Common

+ (NSString *)stringFromDateString:(NSString *)dateStr {
    // Formatter configuration
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    // Date to string
    NSDate *prettyDate = [formatter dateFromString:dateStr];
    
    return [prettyDate timeAgo];
}

@end
