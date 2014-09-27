//
//  GGPrivilegeDetailViewController.m
//  GG
//
//  Created by YANGReal on 14-9-24.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGPrivilegeDetailViewController.h"
#import "GGShareShopViewController.h"
#import "GGGoodsDetailCell.h"
#import "GGReplyViewController.h"
#import "GGPictureViewController.h"
@interface GGPrivilegeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak , nonatomic) IBOutlet UIImageView *coverView;
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (weak , nonatomic) IBOutlet UIView *headerView;
@property (weak , nonatomic) IBOutlet UIView *footerView;

- (IBAction)likeButtonClicked:(id)sender;
- (IBAction)shareButtonClicked:(id)sender;
- (IBAction)gotoPhoto:(id)sender;
@end

@implementation GGPrivilegeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = @"优惠详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupRightButton];
}

- (void)setupViews
{
    self.coverView.clipsToBounds = YES;
    self.headerView.backgroundColor = WHITE_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    self.footerView.backgroundColor = BG_COLOR;
    // self.tableView.tableFooterView = self.footerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(GGMainViewController *)self.tabBarController hideTabBar:NO];
}

- (void)setupRightButton
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = RECT(0, 0, 17, 17);
    [rightBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"edit_icon.png"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)editButtonClicked
{
    
}

- (IBAction)likeButtonClicked:(id)sender
{
    
}
- (IBAction)shareButtonClicked:(id)sender
{
    GGShareShopViewController *vc = [[GGShareShopViewController alloc] initWithNibName:@"GGShareShopViewController" bundle:nil];
    vc.shopImage = [UIImage imageFromView:self.navigationController.view atFrame:self.navigationController.view.bounds];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)gotoPhoto:(id)sender
{
    GGPictureViewController *vc = [[GGPictureViewController alloc] initWithNibName:@"GGPictureViewController" bundle:nil];
    vc.dataArray = @[@"pizza.png"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate method

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    GGGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GGGoodsDetailCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GGGoodsDetailCell cellHeightWithData:nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GGReplyViewController *vc = [[GGReplyViewController alloc] initWithNibName:@"GGReplyViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
