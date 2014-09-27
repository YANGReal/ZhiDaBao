//
//  GGCreateShopViewController.m
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGCreateShopViewController.h"
#import "GGMapViewController.h"
#import "GGShopCompleteViewController.h"

@interface GGCreateShopViewController ()<GGMapViewControllerDelegate,UIImagePickerControllerDelegate>
{
    NSString *shopPlace;
    CGFloat longitude;
    CGFloat latitude;
}
@property (weak , nonatomic) IBOutlet UITextField *textField;
@property (weak , nonatomic) IBOutlet UIView *view1,*view2;
@property (weak , nonatomic) IBOutlet UIButton *imgButton;
- (IBAction)choosePlace:(id)sender;
- (IBAction)choosePicture:(id)sender;
@end

@implementation GGCreateShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"创建店铺";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    self.navigationController.navigationBarHidden = NO;
    self.view1.height = 0.5;
    self.view2.height = 0.5;
    [self setupRightBarButtonItem];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"goNext.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}


- (IBAction)choosePlace:(id)sender
{
    GGMapViewController *vc = [[GGMapViewController alloc] initWithNibName:@"GGMapViewController" bundle:nil];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)choosePicture:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择本地图片",@"拍照", nil];
    NBCallAlbumOrCamera *camera = [[NBCallAlbumOrCamera alloc] initWithViewController:self];
    [actionSheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 0)
        {
            [camera callAlbumOrCamera:PhotoLibrary];
        }
        else if (buttonIndex == 1)
        {
            [camera callAlbumOrCamera:PhotoForCamera];
        }
        
    }];

}


- (void)goNext
{
    if (_textField.text.length == 0)
    {
        [self showMBWithMessage:@"请输入店铺名称"];
        return;
    }
    NSString *token = [AppUtility getObjectForKey:UID];
    NSString *name = _textField.text;
    NSString *url = KCreateShop(token, name, longitude, latitude, @"");
    DLog(@"url = %@",url);
    [NBNetworkEngine loadDataWithURL:url completeHander:^(id jsonObject, BOOL success) {
        NSDictionary *dict = (NSDictionary *)jsonObject;
        DLog(@"dict = %@",dict);
        if ([[dict stringAttribute:RESULT_CODE] isEqualToString:@"200"])
        {
            NSString *shopId = [dict stringAttribute:@"shop_id"];
            [AppUtility storeObject:shopId forKey:@"shopId"];
            GGShopCompleteViewController *vc = [[GGShopCompleteViewController alloc] initWithNibName:@"GGShopCompleteViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else
        {
            NSString *resultMessage = [dict stringAttribute:@"resultMessage"];
            [self showMBWithMessage:resultMessage];
        }
        
    }];
    
}

#pragma mark - UIImagePickerControllerDelegate method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = info[UIImagePickerControllerEditedImage];
    [self.imgButton setImage:img forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - GGMapViewControllerDelegate method

- (void)mapViewController:(GGMapViewController *)mapViewController didChooseCoor:(CLLocationCoordinate2D)coordinate
                WithPlace:(NSString *)place
{
    longitude = coordinate.longitude;
    latitude = coordinate.latitude;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
