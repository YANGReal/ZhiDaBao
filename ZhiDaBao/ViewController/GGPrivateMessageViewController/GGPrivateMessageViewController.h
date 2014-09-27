//
//  GGPrivateMessageViewController.h
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGBaseViewController.h"

typedef enum
{
    kToAll = 0,
    kToSingle
} MessageType;

@interface GGPrivateMessageViewController : GGBaseViewController
@property (assign , nonatomic) MessageType messageType;
@end
