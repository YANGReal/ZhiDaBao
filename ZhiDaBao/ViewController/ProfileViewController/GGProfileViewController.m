//
//  GGProfileViewController.m
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGProfileViewController.h"

#import "GGProfileCell.h"

#import "GGShopSettingViewController.h"
#import "GGAccountPasswordViewController.h"
#import "GGCategoryManageViewController.h"
#import "GGShareShopViewController.h"
#import "GGFansViewControllerr.h"
@interface GGProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (weak , nonatomic) IBOutlet UIView *headerView;
;
@property (weak , nonatomic) IBOutlet UIView *footerView;
@property (strong , nonatomic) NSArray *itemArray;
@property (weak , nonatomic) IBOutlet UIImageView *avatarView;

- (IBAction)loginOut:(id)sender;

@end

@implementation GGProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的店铺";
        self.itemArray = @[@"店铺设置",@"账户设置",@"分类管理",@"我的粉丝"];
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
    self.headerView.backgroundColor = WHITE_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    self.avatarView.clipsToBounds = YES;
    _footerView.backgroundColor = CLEAR_COLOR;
    self.tableView.tableFooterView = _footerView;
}

- (void)setupLeftBarButtonItem
{
    
}

- (IBAction)loginOut:(id)sender
{
    
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate method


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    GGProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GGProfileCell" owner:self options:nil] lastObject];
    }
    cell.title = _itemArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = _itemArray[indexPath.row];
    [(GGMainViewController *)self.tabBarController hideTabBar:YES];
    if ([title isEqualToString:@"店铺设置"])
    {
        GGShopSettingViewController *vc = [[GGShopSettingViewController alloc] initWithNibName:@"GGShopSettingViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    else if ([title isEqualToString:@"账户设置"])
    {
        
        GGAccountPasswordViewController *vc = [[GGAccountPasswordViewController alloc] initWithNibName:@"GGAccountPasswordViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;

    }
    else if ([title isEqualToString:@"分类管理"])
    {
       
        GGCategoryManageViewController *vc = [[GGCategoryManageViewController alloc] initWithNibName:@"GGCategoryManageViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;

    }
    else if ([title isEqualToString:@"分享店铺"])
    {
       
        GGShareShopViewController *vc = [[GGShareShopViewController alloc] initWithNibName:@"GGShareShopViewController" bundle:nil];
        vc.shopImage = [UIImage imageFromView:self.navigationController.view atFrame:self.navigationController.view.bounds];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    else if ([title isEqualToString:@"我的粉丝"])
    {
        //GGFansViewControllerr
        GGFansViewControllerr *vc = [[GGFansViewControllerr alloc] initWithNibName:@"GGFansViewControllerr" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;

    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[(GGMainViewController *)self.tabBarController showTabBar:YES];
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
