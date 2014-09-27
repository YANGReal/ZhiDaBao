//
//  GGSetPasswordViewController.h
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGBaseViewController.h"

@interface GGSetPasswordViewController : GGBaseViewController
@property (copy , nonatomic) NSString *verifyCode;
@property (copy , nonatomic) NSString *phoneNumber;
@property (assign , nonatomic) BOOL forget;
@end
