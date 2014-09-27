//
//  GGMessageViewController.m
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGMessageViewController.h"
#import "GGMessageCell.h"
#import "GGReplyViewController.h"
@interface GGMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (weak , nonatomic) IBOutlet UIView *headerView;
@property (strong , nonatomic) YRSegmentControl *segmentControl;
@end

@implementation GGMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"消息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews
{
    self.segmentControl = [[YRSegmentControl alloc] initWithFrame:RECT(0, 0, 200, 30) items:@[@"评论",@"私信"]];
    self.segmentControl.borderCorner = 5;
    self.segmentControl.borderColor = WHITE_COLOR;
    
    self.segmentControl.font = [UIFont systemFontOfSize:14];
    [self.segmentControl setTitleColor:BLACK_COLOR forState:UIControlStateSelected];
    [self.segmentControl setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [self.segmentControl setItemColor:WHITE_COLOR forState:UIControlStateSelected];
    [self.segmentControl setItemColor:NAVBAR_COLOR forState:UIControlStateNormal];
    self.navigationItem.titleView = self.segmentControl;
    self.headerView.backgroundColor = CLEAR_COLOR;
    self.tableView.tableHeaderView = _headerView;
}


- (void)setupLeftBarButtonItem
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [(GGMainViewController *)self.tabBarController showTabBar:YES];
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    GGMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GGMessageCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 99;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(GGMainViewController *)self.tabBarController hideTabBar:YES];
    GGReplyViewController *vc = [[GGReplyViewController alloc] initWithNibName:@"GGReplyViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
