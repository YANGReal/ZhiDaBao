//
//  GGDiscoveryViewController.m
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGPrivilegeViewController.h"
#import "GGHomePageCell.h"
#import "GGPrivilegeDetailViewController.h"
#import "GGAddPrivilegeViewController.h"
typedef enum
{
    playerType =0,
    groupType = 1,
    competitionType = 2
}DataType;

@interface GGPrivilegeViewController ()<YRSegmentControlDelegate,UITableViewDelegate,UITableViewDataSource>
{
   
}
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic) YRSegmentControl *segmentControl;
@property (strong , nonatomic) NSArray *titleArray;
@property (strong , nonatomic) NSMutableArray *dataArray;
@property (strong , nonatomic) UIButton *rightBtn;
@property (assign , nonatomic) DataType dataType;
@end

@implementation GGPrivilegeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"优惠列表";
        self.dataArray = [NSMutableArray array];
        self.titleArray = @[@"附近的玩家",@"附近的群组",@"赛事活动"];
        self.dataType = playerType;
       // page = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupLeftBarButtonItem];
    [self setupRightBarButtonItem];
    // Do any additional setup after loading the view from its nib.
    
    //NSString *userName = [AppUtility getObjectForKey:USER_NAME];
}

- (void)viewWillAppear:(BOOL)animated
{
    [(GGMainViewController *)self.tabBarController showTabBar:YES];
}


- (void)setupViews
{
    
}

- (void)setupLeftBarButtonItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = RECT(0, 0, 17, 17);
    [rightBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"edit_icon.png"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}



- (void)setupRightBarButtonItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = RECT(0, 0, 17, 17);
    [rightBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"add_icon.png"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightBtnCLicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)rightBtnCLicked:(UIButton *)sender
{
    [(GGMainViewController *)self.tabBarController hideTabBar:YES];
    GGAddPrivilegeViewController *vc = [[GGAddPrivilegeViewController alloc] initWithNibName:@"GGAddPrivilegeViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editButtonClicked
{
    [self.tableView setEditing:!_tableView.editing animated:YES];
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    GGHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GGHomePageCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(GGMainViewController *)self.tabBarController hideTabBar:YES];
    GGPrivilegeDetailViewController *vc = [[GGPrivilegeDetailViewController alloc] initWithNibName:@"GGPrivilegeDetailViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}




#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
