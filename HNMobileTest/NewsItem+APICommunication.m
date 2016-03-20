//
//  NewsItem+APICommunication.m
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import "NewsItem+APICommunication.h"
#import "AFNetworking.h"

static NSString *const HNMFeedWebserviceURLString = @"http://hn.algolia.com/api/v1/search_by_date?query=ios";

@implementation NewsItem (APICommunication)


+ (void)latestFeedWithResponseBlock:(APIRequestResponseBlock)responseBlock {

    NSURL *URL = [NSURL URLWithString:HNMFeedWebserviceURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = responseObject;
        NSArray *responseItems = [dict valueForKey:@"hits"];
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[responseItems count]];
        for (id dict in responseItems) {
            NewsItem *newsItem = [NewsItem newsItemFromDict:dict];
            [items addObject:newsItem];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[AppController dataManager] writeArrayWithCustomObjToUserDefaultsWithArray:items];
        });
        
        responseBlock([items copy] , TRUE, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        if (error.code == -1005) {
            [[self class] latestFeedWithResponseBlock:responseBlock];
        } else {
            responseBlock(nil, FALSE, error);
        }
        
    }];
    [op start];
    
}

@end
