//
//  GGAddGoodViewController.m
//  GG
//
//  Created by YANGReal on 14-9-24.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGAddGoodViewController.h"

@interface GGAddGoodViewController ()<UIImagePickerControllerDelegate>
@property (weak , nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak , nonatomic) IBOutlet UIView *bgView;
@property (weak , nonatomic) IBOutlet UITextField *nameField;
@property (weak , nonatomic) IBOutlet UITextField *priceField;
@property (weak , nonatomic) IBOutlet UITextField *descField;
@property (weak , nonatomic) IBOutlet UITextField *oldPriceField;
@property (weak , nonatomic) IBOutlet UITextField *uinitField;
@property (weak , nonatomic) IBOutlet UILabel *cateLabel;
@property (strong, nonatomic) NSMutableArray *pictureAray;
@property (weak , nonatomic) IBOutlet UIImageView *imgView1,*imgView2,*imgView3;
@property (weak , nonatomic) IBOutlet UIView *pictureBGView;

- (IBAction)choosePicture:(id)sender;
- (IBAction)chooseCate:(id)sender;
- (IBAction)addCate:(id)sender;

@end

@implementation GGAddGoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"商品添加";
        self.pictureAray = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupRightBarButtonItem];
    
    for (UIView *view in _bgView.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            view.backgroundColor = CLEAR_COLOR;
        }
    }
    self.scrollView.contentSize = SIZE(self.view.width, self.view.height+100);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [self.scrollView addGestureRecognizer:tap];
    
    [self.imgView1 setupBorder:C2 cornerRadius:0];
    [self.imgView2 setupBorder:C2 cornerRadius:0];
    [self.imgView3 setupBorder:C2 cornerRadius:0];
}

- (void)tapped
{
    for (UIView *view in _bgView.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            [view resignFirstResponder];
        }
    }

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
- (IBAction)chooseCate:(id)sender
{
    NSArray *array = @[@"饮料",@"面食",@"凉皮",@"玩具"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择商品分类" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"饮料",@"面食",@"凉皮",@"玩具", nil];
    [actionSheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
       if (buttonIndex !=4)
       {
           self.cateLabel.text = array[buttonIndex];
       }
        
    }];
}
- (IBAction)addCate:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入类名" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]
    ;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
        
        if (buttonIndex !=0)
        {
            UITextField *textField = [alert textFieldAtIndex:0];
            if (textField.text.length!=0)
            {
                self.cateLabel.text = textField.text;
            }
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = info[UIImagePickerControllerEditedImage];
    if (self.pictureAray.count<3)
    {
        [self.pictureAray addObject:img];
    }
    [self setPictureViews];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)setPictureViews
{
    for (NSInteger i = 0;i<_pictureAray.count;i++)
    {
        UIImageView *imgView = (UIImageView *)[self.pictureBGView viewWithTag:i+100];
        imgView.image = _pictureAray[i];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
