//
//  AppController.m
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import "AppController.h"
#import "NSDate+TimeAgo.h"
#import "Reachability.h"

static NSString *const HNMUserDefaultsKey = @"UserDefaultsKey";

@implementation AppController

+ (instancetype)dataManager {
    static AppController *sharedMyManager = nil;
    
    @synchronized(self) {
        if (sharedMyManager == nil) {
            sharedMyManager = [[self alloc] init];
        }
    }
    return sharedMyManager;
}


-(void)writeArrayWithCustomObjToUserDefaultsWithArray:(NSMutableArray *)array {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [defaults setObject:data forKey:HNMUserDefaultsKey];
    [defaults synchronize];
}

-(NSArray *)readArrayWithCustomObjFromUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:HNMUserDefaultsKey];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    return myArray;
}

+ (BOOL)isInternetNotAvailable {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        return FALSE;
    } else {
        return TRUE;
    }
}

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

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

@end
