//
//  GGInputContentViewController.m
//  GG
//
//  Created by YANGReal on 14-7-20.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGInputContentViewController.h"

@interface GGInputContentViewController ()<UITextViewDelegate>
@property (weak , nonatomic) IBOutlet UITextView *textView;
@property (weak , nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation GGInputContentViewController

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
    [self setupViews];
    [self setupRightBarItem];
}

- (void)setupViews
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.textView setupBorder:C3 cornerRadius:4];
    self.textView.backgroundColor = WHITE_COLOR;
    [self.textView becomeFirstResponder];
    self.countLabel.text = [NSString stringWithFormat:@"0/%d",(int)_textLength];
}

- (void)setupRightBarItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = RECT(0, 0, 40, 30);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

- (void)rightBarButtonClicked
{
    if (_textView.text.length != 0)
    {
        if ([self.delegate respondsToSelector:@selector(backFromGGInputContentViewController:withContent:)])
        {
            [self.delegate backFromGGInputContentViewController:self withContent:_textView.text];
        }
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showMBWithMessage:[NSString stringWithFormat:@"请输入%@",self.title]];
    }
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.countLabel.text = [NSString stringWithFormat:@"%d/%d",(int)textView.text.length,(int)_textLength];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
