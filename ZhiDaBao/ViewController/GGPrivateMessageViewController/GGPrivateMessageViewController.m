//
//  GGPrivateMessageViewController.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGPrivateMessageViewController.h"

@interface GGPrivateMessageViewController ()
@property (weak , nonatomic) IBOutlet UITextView *textView;
@property (weak , nonatomic) IBOutlet UILabel *allLabel;
@end

@implementation GGPrivateMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"私信";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.backgroundColor = CLEAR_COLOR;
    [self.textView setupBorder:C4 cornerRadius:4];
    self.allLabel.hidden = self.messageType==kToSingle;
    [self setupRightBarButtonItem];
    // Do any additional setup after loading the view from its nib.
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
