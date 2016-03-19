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


@implementation ListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _newsItems = [[NSMutableArray alloc] init];
    
    [DejalActivityView activityViewForView:self.view withLabel:@"Loading ..."];
    [self sendNewsItemRequest];
    
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
    NSString *title = [NSString stringWithFormat:@"update %@ ago", [currentDate timeAgo]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    self.refreshControl.attributedTitle = attributedTitle;
    
    [self.refreshControl endRefreshing];
}

- (void)sendNewsItemRequest
{
    [self.newsItems removeAllObjects];
    [NewsItem latestFeedWithResponseBlock:^(id object, BOOL status, NSError *error) {
        
        if (status && object) {
            [self.newsItems addObjectsFromArray:(NSArray*)object];
            [self.tableView reloadData];
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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];// like Main.storyboard for used "Main"
        DetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailViewController.URLString = newsItem.storyURLStr;
        //To show Back
        [self.navigationController pushViewController:detailViewController animated:YES];
    } else {
        [Common showAlertWithTitle:nil message:@"No details found"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.newsItems removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
