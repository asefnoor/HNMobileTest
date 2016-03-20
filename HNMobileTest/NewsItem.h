//
//  NewsItem.h
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject <NSCoding>

@property (nonatomic,strong) NSString *itemID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *storyURLStr;
@property (nonatomic,strong) NSString *dateTimeStr;

+ (instancetype)newsItemFromDict:(NSDictionary *)dict;

@end
