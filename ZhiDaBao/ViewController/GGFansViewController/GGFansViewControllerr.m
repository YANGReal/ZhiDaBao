//
//  GGFansViewControllerr.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGFansViewControllerr.h"
#import "GGFansCell.h"
#import "GGPrivateMessageViewController.h"
#import "GGFansDetailViewController.h"
@interface GGFansViewControllerr ()<UITableViewDataSource,UITableViewDelegate,GGFansCellDelegate>
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@end

@implementation GGFansViewControllerr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRightBarButtonItem];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 40, 23);
    [btn setTitle:@"群发" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)buttonClicked
{
    GGPrivateMessageViewController *vc = [[GGPrivateMessageViewController alloc] initWithNibName:@"GGPrivateMessageViewController" bundle:nil];
    vc.messageType = kToAll;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back
{
    [(GGMainViewController *)self.tabBarController showTabBar:YES];
    [super back];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    GGFansCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GGFansCell" owner:self options:nil] lastObject];
    }
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //GGFansDetailViewController
    GGFansDetailViewController *vc = [[GGFansDetailViewController alloc] initWithNibName:@"GGFansDetailViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - GGFansCellDelegate

- (void)fansCell:(GGFansCell *)cell
didClickPrivateMessageWithIndex:(NSInteger)index
{
    GGPrivateMessageViewController *vc = [[GGPrivateMessageViewController alloc] initWithNibName:@"GGPrivateMessageViewController" bundle:nil];
    vc.messageType = kToSingle;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
