//
//  Common.h
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^APIRequestResponseBlock) (id object, BOOL status, NSError *error);

@interface Common : NSObject

+ (NSString *)stringFromDateString:(NSString *)dateStr;

@end
