//
//  GGCategoryManageViewController.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGCategoryManageViewController.h"

@interface GGCategoryManageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak , nonatomic) IBOutlet UIView *headerView;
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic) NSMutableArray *dataArray;
@end

@implementation GGCategoryManageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"分类管理";
        self.dataArray = [@[@"饮料",@"面食",@"凉皮",@"主食",@"玩具",@"酒水"] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableHeaderView = self.headerView;
    [self setupRightBarButtonItem];
}
- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"add_icon.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)addButtonClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入类名" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert showWithCompletionHandler:^(NSInteger buttonIndex)
    {
        UITextField *textField = [alert textFieldAtIndex:0];
       // DLog(@"index = %d",buttonIndex);
        if (buttonIndex != 0)
        {
            if (textField.text.length!=0)
            {
                [self.dataArray insertObject:textField.text atIndex:0];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)back
{
    [(GGMainViewController *)self.tabBarController showTabBar:YES];
    [super back];

}

#pragma mark - UITableViewDataSource,UITableViewDelegate method


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = BLACK_COLOR;
        UIView *line = [[UIView alloc] initWithFrame:RECT(10, cell.height-1, 300, 0.5)];
        line.backgroundColor = BG_COLOR;
        [cell.contentView addSubview:line];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}


#pragma amrk - memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
