//
//  ViewController.m
//  HNMobileTest
//
//  Created by Asif Noor on 3/19/16.
//  Copyright © 2016 Asif Noor. All rights reserved.
//

#import "ListViewController.h"
#import "NewsItem+APICommunication.h"

#import "ListTableViewCell.h"
#import "DetailViewController.h"

#import "DejalActivityView.h"
#import "NSDate+TimeAgo.h"

@interface ListViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *newsItems;

@end

static NSString *const HNMTitleCell = @"HNMTitleCell";
static NSString *const HNMAlertMessage = @"HNMobile could not load from local storage. Please pull down to refresh to fetch latest items.";

@implementation ListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _newsItems = [[NSMutableArray alloc] init];
    
    if ([AppController isInternetNotAvailable]) {
        NSArray *items = [[AppController dataManager] readArrayWithCustomObjFromUserDefaults];
        if ([items count] == 0) {
            [AppController showAlertWithTitle:nil message:HNMAlertMessage];
        } else {
            [self.newsItems addObjectsFromArray:items];
        }
    } else {
        
      [DejalActivityView activityViewForView:self.view withLabel:@"Loading ..."];
      [self sendNewsItemRequest];
    }
  
    [self setupRefreshControl];
}

- (void)setupRefreshControl {
    
    // Do any additional setup after loading the view, typically from a nib.
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(fetchLatestNewsItems) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.backgroundColor = [UIColor greenColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
}

- (void)fetchLatestNewsItems {
    
    [self sendNewsItemRequest];
    
    NSDate *currentDate = [NSDate date];
    NSString *title = [NSString stringWithFormat:@"updated %@", [currentDate timeAgo]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    self.refreshControl.attributedTitle = attributedTitle;
    
    [self.refreshControl endRefreshing];
}

- (void)sendNewsItemRequest
{
    __weak typeof(self) weakSelf = self;
    
    [NewsItem latestFeedWithResponseBlock:^(id object, BOOL status, NSError *error) {
        if (status && object) {
            [weakSelf.newsItems removeAllObjects];
            [weakSelf.newsItems addObjectsFromArray:(NSArray*)object];
            [weakSelf.tableView reloadData];
        }
        [DejalActivityView removeView];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HNMTitleCell forIndexPath:indexPath];
    
    NewsItem *newsItem = [self.newsItems objectAtIndex:indexPath.row];
    cell.newsItem = newsItem;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsItem *newsItem = [self.newsItems objectAtIndex:indexPath.row];
    if (newsItem.storyURLStr.length >0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailViewController.URLString = newsItem.storyURLStr;
        [self.navigationController pushViewController:detailViewController animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        [AppController showAlertWithTitle:nil message:@"No details found"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.newsItems removeObjectAtIndex:indexPath.row];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[AppController dataManager] writeArrayWithCustomObjToUserDefaultsWithArray:self.newsItems ];
        });
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
