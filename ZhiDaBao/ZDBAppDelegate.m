//
//  ZDBAppDelegate.m
//  ZhiDaBao
//
//  Created by YANGReal on 14-9-27.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

#import "ZDBAppDelegate.h"
#import "UMSocialQQHandler.h"
#import "GGLoginViewController.h"
#import "UMSocialWechatHandler.h"
@implementation ZDBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    if ([AppUtility userDidLogin])
    {
        self.mainVC = [[GGMainViewController alloc] init];
        self.mainVC.tabBar.hidden = YES;
        self.window.rootViewController = self.mainVC;
    }
    else
    {
        GGLoginViewController *vc = [[GGLoginViewController alloc] initWithNibName:@"GGLoginViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
        
    }
    
    /*设置导航栏背景颜色*/
    [[UINavigationBar appearance] setBarTintColor:NAVBAR_COLOR];
    /*设置导航栏字体颜色和字体*/
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: WHITE_COLOR,NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [self initialSocialNetworkService];
    return YES;
}


- (void)initialSocialNetworkService
{
    
    [UMSocialData setAppKey:kUMKey];
    [UMSocialQQHandler setQQWithAppId:@"1103188914"
                                appKey:@"rpBsXvCGijErsMfi"
                                   url:@"http://www.qq.com"];
     [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6"
                                   url:@"http://www.umeng.com/social"];
}


- (void)switchRootViewController
{
    
    self.mainVC = [[GGMainViewController alloc] init];
    self.mainVC.tabBar.hidden = YES;
    self.window.rootViewController = self.mainVC;
}

- (void)goLogin
{
    GGLoginViewController *vc = [[GGLoginViewController alloc] initWithNibName:@"GGLoginViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
openURL:(NSURL *)url
sourceApplication:(NSString *)sourceApplication
annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

@end
