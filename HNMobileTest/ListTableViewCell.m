//
//  ListTableViewCell.m
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import "ListTableViewCell.h"
#import "Common.h"

@implementation ListTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsItem:(NewsItem *)newsItem {
    NSLog(@"title:%@",newsItem.title);
    self.titleLabel.text = [newsItem.title length] == 0 ? @"No title found": newsItem.title;
    NSString *dateStr = [Common stringFromDateString:newsItem.dateTimeStr];
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@ - %@",newsItem.author,dateStr];
    
}

@end
