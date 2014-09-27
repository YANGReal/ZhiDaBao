//
//  GGShopSettingViewController.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGShopSettingViewController.h"
#import "NBCallAlbumOrCamera.h"
#import "GGMapViewController.h"
@interface GGShopSettingViewController ()<UIImagePickerControllerDelegate>
{
    BOOL isIcon;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak , nonatomic) IBOutlet UILabel *typeLabel;
@property (weak , nonatomic) IBOutlet UILabel *cateLabel;
@property (weak , nonatomic) IBOutlet UITextField *nameField;
@property (weak , nonatomic) IBOutlet UITextView *descTextView;
@property (weak , nonatomic) IBOutlet UITextField *addressField;
@property (weak , nonatomic) IBOutlet UITextField *phoneField;
@property (weak , nonatomic) IBOutlet UIButton *iconButton;
@property (weak , nonatomic) IBOutlet UIButton *coverButton;


- (IBAction)chooseShopType:(id)sender;
- (IBAction)chooseShopCate:(id)sender;
- (IBAction)setShopLocation:(id)sender;
- (IBAction)iconButtonClicked:(id)sender;
- (IBAction)coverButtonClicked:(id)sender;
@end

@implementation GGShopSettingViewController

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
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupRightBarButtonItem];
}

- (void)setupViews
{
    self.nameField.backgroundColor = CLEAR_COLOR;
    self.phoneField.backgroundColor = CLEAR_COLOR;
    self.addressField.backgroundColor = CLEAR_COLOR;
    self.scrollView.backgroundColor = CLEAR_COLOR;
    self.scrollView.contentSize = SIZE(self.view.width, self.view.height+100);
    if (!ISIP5)
    {
         self.scrollView.contentSize = SIZE(self.view.width, self.view.height+150);
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)back
{
     [(GGMainViewController *)self.tabBarController showTabBar:YES];
    [super back];
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"ok_icon.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)okButtonClicked
{
    
}

- (void)dismissKeyboard
{
    [self.nameField resignFirstResponder];
    [self.descTextView resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.addressField resignFirstResponder];
}

- (IBAction)chooseShopType:(id)sender
{
    //NSArray *array = @[@"商场用户",@"独立商户"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择商户类别" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"商场用户",@"独立商户", nil];
    [actionSheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
        //DLog(@"buttonIndex = %d",buttonIndex);
        if (buttonIndex == 0)
        {
            self.typeLabel.text = @"商场用户";
        }
        if (buttonIndex == 1)
        {
            self.typeLabel.text = @"独立商户";
        }
    }];
}


- (IBAction)chooseShopCate:(id)sender
{
    NSArray *array = @[@"美食",@"服装",@"亲子",@"娱乐",@"购物",@"丽人",@"结婚",@"家装",@"运动健身",@"其他"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择所属类别" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"美食",@"服装",@"亲子",@"娱乐",@"购物",@"丽人",@"结婚",@"家装",@"运动健身",@"其他", nil];
    [actionSheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
      //  DLog(@"buttonIndex = %d",buttonIndex);
        if (buttonIndex != 10)
        {
            self.cateLabel.text = array[buttonIndex];
        }
    }];

}
- (IBAction)setShopLocation:(id)sender
{
    GGMapViewController *vc = [[GGMapViewController alloc] initWithNibName:@"GGMapViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)iconButtonClicked:(id)sender
{
    isIcon = YES;
    NBCallAlbumOrCamera *camera = [[NBCallAlbumOrCamera alloc] initWithViewController:self];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
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

- (IBAction)coverButtonClicked:(id)sender
{
    isIcon = NO;
    NBCallAlbumOrCamera *camera = [[NBCallAlbumOrCamera alloc] initWithViewController:self];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
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

#pragma mark -UIImagePickerControllerDelegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (isIcon)
    {
        [self.iconButton setImage:image forState:UIControlStateNormal];
    }
    else
    {
          [self.coverButton setImage:image forState:UIControlStateNormal];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
