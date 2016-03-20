//
//  Common.h
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^APIRequestResponseBlock) (id object, BOOL status, NSError *error);

@interface AppController : NSObject

+ (instancetype)dataManager;

+ (BOOL)isInternetNotAvailable;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (NSString *)stringFromDateString:(NSString *)dateStr;
-(NSArray *)readArrayWithCustomObjFromUserDefaults;
-(void)writeArrayWithCustomObjToUserDefaultsWithArray:(NSMutableArray *)array;


@end
