//
//  NewsItem.m
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

static inline NSString* emptyStringIfNull(NSString *s) {
    return (s == (id)[NSNull null])?@"" : s;
}

- (instancetype)initNewItemWithDict:(NSDictionary *)dict {
    
    self.itemID = emptyStringIfNull([dict valueForKey:@"story_id"]) ;
    self.title = emptyStringIfNull([dict valueForKey:@"story_title"]);
    self.author = emptyStringIfNull([dict valueForKey:@"author"]);
    self.dateTimeStr = emptyStringIfNull([dict valueForKey:@"created_at"]);
    self.storyURLStr = emptyStringIfNull([dict valueForKey:@"story_url"]);
    
    return self;
}

+ (instancetype)newsItemFromDict:(NSDictionary *)dict {
    
    return [[self alloc] initNewItemWithDict:dict];
}

@end
