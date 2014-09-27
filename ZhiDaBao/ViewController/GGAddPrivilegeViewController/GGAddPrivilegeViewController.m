//
//  GGAddPrivilegeViewController.m
//  GG
//
//  Created by YANGReal on 14-9-24.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGAddPrivilegeViewController.h"

@interface GGAddPrivilegeViewController ()
<UIImagePickerControllerDelegate>
{
    BOOL start;
}
@property (weak , nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak , nonatomic) IBOutlet UIView *bgView;
@property (weak , nonatomic) IBOutlet UITextView *textView;
@property (weak , nonatomic) IBOutlet UIView *dateView;
@property (weak , nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) NSMutableArray *pictureAray;
@property (weak , nonatomic) IBOutlet UIImageView *imgView1,*imgView2,*imgView3;
@property (weak , nonatomic) IBOutlet UIView *pictureBGView;
@property (weak , nonatomic) IBOutlet UILabel *startLabel;

@property (weak , nonatomic) IBOutlet UILabel *endLabel;


- (IBAction)choosePicture:(id)sender;

- (IBAction)chooseDateButtonClicked:(UIButton *)sender;

- (IBAction)done:(id)sender;

@end

@implementation GGAddPrivilegeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"y优惠添加";
        self.pictureAray = [NSMutableArray arrayWithCapacity:3];
        start = YES;
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
    self.scrollView.contentSize = SIZE(self.view.width, self.view.height+50);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [self.scrollView addGestureRecognizer:tap];
    
    [self.imgView1 setupBorder:C2 cornerRadius:0];
    [self.imgView2 setupBorder:C2 cornerRadius:0];
    [self.imgView3 setupBorder:C2 cornerRadius:0];
    self.dateView.alpha = 0;
}

- (void)tapped
{
    [_textView resignFirstResponder];
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


- (IBAction)chooseDateButtonClicked:(UIButton *)sender
{
    if (sender.tag == 100)
    {
        start = YES;
    }
    else
    {
        start = NO;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
       self
        .dateView.alpha = 1;
    }];
}

- (IBAction)done:(id)sender
{
    if (start)
    {
        self.startLabel.text = [self dateStringWithDate:_datePicker.date];
    }
    else
    {
          self.endLabel.text = [self dateStringWithDate:_datePicker.date];
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.dateView.alpha = 0;
    }];
}

- (NSString *)dateStringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter stringFromDate:date];
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
