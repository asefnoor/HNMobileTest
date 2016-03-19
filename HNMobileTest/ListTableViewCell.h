//
//  ListTableViewCell.h
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface ListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (nonatomic,strong) NewsItem *newsItem;

@end
