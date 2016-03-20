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

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemID forKey:@"story_id"];
    [aCoder encodeObject:self.title forKey:@"story_title"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.dateTimeStr forKey:@"created_at"];
    [aCoder encodeObject:self.storyURLStr forKey:@"story_url"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.itemID = emptyStringIfNull([aDecoder decodeObjectForKey:@"story_id"]);
        self.title = emptyStringIfNull([aDecoder decodeObjectForKey:@"story_title"]);
        self.author = emptyStringIfNull([aDecoder decodeObjectForKey:@"author"]);
        self.dateTimeStr = emptyStringIfNull([aDecoder decodeObjectForKey:@"created_at"]) ;
        self.storyURLStr = emptyStringIfNull([aDecoder decodeObjectForKey:@"story_url"]);
    }
    return self;
}


@end
