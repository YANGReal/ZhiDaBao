//
//  GBMainViewController.m
//  GroupBuy
//
//  Created  YANGReal on 14-3-20.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

#import "GGMainViewController.h"
#import "GGGoodListViewController.h"
#import "GGPrivilegeViewController.h"

#import "GGMessageViewController.h"
#import "GGProfileViewController.h"
//#import "GBAuctionViewController.h"

#define kNormalColor [UIColor colorWithHexString:@"#8c8c8c"]

@interface GGMainViewController ()

@property (strong , nonatomic) UIView *myTabBar;
@property (strong , nonatomic) NSArray *itemArray;

@property (strong , nonatomic) NSArray *titleArray;
@end

@implementation GGMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"GG";
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setupTabBar];
    [self setupViewControllers];
   
    // Do any additional setup after loading the view.
}



#pragma mark - 自定义UITabBar
/*自定义UITabBar*/
- (void)setupTabBar
{
    CGFloat iconSpace = 48;
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.myTabBar = [[UIView alloc] initWithFrame:RECT(0, DEVICE_HEIGHT-49, DEVICE_WIDTH, 49)];
    self.myTabBar.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [self.view addSubview:self.myTabBar];
    self.itemArray = @[@"商品",@"优惠",@"消息",@"店铺"];
    NSArray *iconArr1 = @[@"goods.png",@"privilege.png",@"msg.png",@"shop.png"];
    NSArray *iconArr2 = @[@"goods_s.png",@"privilege_s.png",@"msg_s.png",@"shop_s.png"];
    CGFloat btnWidth = rect.size.width/4.0;
    for (int i = 0;i<4;i++)
    {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:RECT(25+30*i+iconSpace*i, 15, 30,30)];
        iconView.tag = 100 + i;
        iconView.image = [UIImage imageFromMainBundleFile:iconArr1[i]];
        iconView.highlightedImage = [UIImage imageFromMainBundleFile:iconArr2[i]];
              [self.myTabBar addSubview:iconView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 100;
        button.frame = RECT(i*btnWidth, 0, btnWidth, 49);
        [button addTarget:self action:@selector(tabBarTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.myTabBar addSubview:button];
      
        
        if (i == 0)
        {
            iconView.highlighted = YES;
        }
    }
  
}

#pragma mark - 设置UITabBarController的子视图控制器

- (void)setupViewControllers
{
   
   GGGoodListViewController *homeVC = [[GGGoodListViewController alloc] initWithNibName:@"GGGoodListViewController" bundle:nil];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
   GGPrivilegeViewController *discoveryVC = [[GGPrivilegeViewController alloc] initWithNibName:@"GGPrivilegeViewController" bundle:nil];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:discoveryVC];
   
    GGMessageViewController *messageVC = [[GGMessageViewController alloc] initWithNibName:@"GGMessageViewController" bundle:nil];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:messageVC];
   
    GGProfileViewController *relationVC = [[GGProfileViewController alloc] initWithNibName:@"GGProfileViewController" bundle:nil];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:relationVC];
    self.viewControllers = @[nav1,nav2,nav3,nav4];
}


#pragma mark - 点击tabBar时候调用
- (void)tabBarTapped:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    self.selectedIndex = index;
    
    for (UIView *view in self.myTabBar.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]])
        {
            UIImageView *icon = (UIImageView *)view;
           
            if (icon.tag == sender.tag)
            {
                icon.highlighted = YES;
            }
            else
            {
                icon.highlighted = NO;
            }
        }
    }
}


#pragma mark - 隐藏TabBar
- (void)hideTabBar:(BOOL)animated;
{
    CGFloat duration = 0;
    if (animated)
    {
        duration = 0.3;
    }
   
    [UIView animateWithDuration:duration animations:^{
        
        self.myTabBar.x = -self.myTabBar.width;
    }];
}

#pragma mark - 显示TabBar
- (void)showTabBar:(BOOL)animated;
{
    CGFloat duration = 0;
    if (animated)
    {
        duration = 0.3;
    }

    [UIView animateWithDuration:duration animations:^{
        
        self.myTabBar.x = 0;
    }];
    
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self hideTabBar];
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self revealTabBar];
//}
#pragma mark - 内存警告时调用
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedTabBarAtIndex:(int)index
{
    for (UIView *view in self.myTabBar.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]])
        {
            UIImageView *icon = (UIImageView *)view;
            
            if (icon.tag == index+100)
            {
                icon.highlighted = YES;
            }
            else
            {
                icon.highlighted = NO;
            }
        }
        
        if ([view isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)view;
            if (label.tag == index+100)
            {
                label.textColor = RED_COLOR;
            }
            else
            {
                label.textColor = WHITE_COLOR;
            }
        }
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
