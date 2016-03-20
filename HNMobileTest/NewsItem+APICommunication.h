//
//  NewsItem+APICommunication.h
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"
#import "AppController.h"

@interface NewsItem (APICommunication)

+ (void)latestFeedWithResponseBlock:(APIRequestResponseBlock)responseBlock;
@end
