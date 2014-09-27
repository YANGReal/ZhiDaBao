//
//  GGHomePageViewController.m
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGGoodListViewController.h"
#import "GGGoodListCell.h"
#import "GGHomePageCell.h"
#import "GGGoodsDetailViewController.h"
#import "GGAddGoodViewController.h"


@interface GGGoodListViewController ()<UITableViewDataSource,UITableViewDelegate,GGHomePageCellDelegate,UIActionSheetDelegate>
{
     int page;
    BOOL edit;
    
}
@property (weak , nonatomic) IBOutlet UIView *promptView;
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic) NSMutableArray *dataArray;
@property (weak , nonatomic) IBOutlet UIView *headerView;
@property (strong , nonatomic) UIButton *leftButton;
@property (strong , nonatomic) UIButton *rightButton;
@end

@implementation GGGoodListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"商品列表";
        self.dataArray = [NSMutableArray array];
        page = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRightBarButtonItem];
    [self setupRefresh];
    [self rereshing];
}

- (void)viewWillAppear:(BOOL)animated
{
     [(GGMainViewController *)self.tabBarController showTabBar:YES];
}


- (void)setupRefresh
{
   
    self.tableView.tableHeaderView = self.headerView;
    self.promptView.backgroundColor = CLEAR_COLOR;
    self.promptView.hidden = YES;

}



#pragma mark 开始进入刷新状态
- (void)rereshing
{
    NSString *shop_id = [AppUtility getObjectForKey:@"shopId"];
   
    NSString *url = kGoodsListURL(page,shop_id);
    DLog(@"url = %@",url);
    [NBNetworkEngine loadDataWithURL:url completeHander:^(id jsonObject, BOOL success) {
        NSDictionary *dict = (NSDictionary *)jsonObject;
        if ([[dict stringAttribute:RESULT_CODE] isEqualToString:@"200"])
        {
            page ++;
            NSDictionary *data = dict[@"data"];
            if ([data isKindOfClass:[NSDictionary class]])
            {
                NSArray *array = data[@"list"];
                if ([array isKindOfClass:[NSArray class]])
                {
                    if (array.count>0)
                    {
                        for (NSDictionary *dic in array)
                        {
                            [self.dataArray addObject:dic];
                        }
                        [_tableView reloadData];
                    }
                    else
                    {
                        [self showMBWithMessage:@"没有了哦"];
                    }
                }
                else
                {
                    [self showMBWithMessage:@"暂无数据"];
                }
        
            }
            else
            {
                [self showMBWithMessage:@"暂无数据"];
            }
            
        }
        DLog(@"json = %@",jsonObject);
    }];
}

- (void)setupLeftBarButtonItem
{
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
     self.leftButton.frame = RECT(0, 0, 25, 25);
    [ self.leftButton setBackgroundImage:[UIImage imageFromMainBundleFile:@"edit_icon.png"] forState:UIControlStateNormal];
     [self.leftButton setBackgroundImage:[UIImage imageFromMainBundleFile:@"ok_icon.png"] forState:UIControlStateSelected];
    [ self.leftButton addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.leftButton];
}



- (void)setupRightBarButtonItem
{
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.rightButton.frame = RECT(0, 0, 25, 25);
    [self.rightButton setBackgroundImage:[UIImage imageFromMainBundleFile:@"add_icon.png"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightBtnCLicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}

- (void)rightBtnCLicked:(UIButton *)sender
{
    [(GGMainViewController *)self.tabBarController hideTabBar:YES];
    GGAddGoodViewController *vc = [[GGAddGoodViewController alloc] initWithNibName:@"GGAddGoodViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editButtonClicked
{
   
    [self.tableView setEditing:!edit animated:YES];
    self.leftButton.selected = !edit;
    self.rightButton.hidden = !edit;
    edit = !edit;
    
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    _promptView.hidden = _dataArray.count!=0;
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    GGGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GGGoodListCell" owner:self options:nil] lastObject];
    }
    cell.data = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 110;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (edit)
    {
        
    }
    else
    {
        GGGoodsDetailViewController *detailVC = [[GGGoodsDetailViewController alloc] initWithNibName:@"GGGoodsDetailViewController" bundle:nil];
        [(GGMainViewController *)self.tabBarController hideTabBar:YES];
        [self.navigationController pushViewController:detailVC animated:YES];

    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc
{
    DLog(@"%@ dealloc",self);
}

@end
