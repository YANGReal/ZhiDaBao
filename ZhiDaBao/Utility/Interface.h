//
//  Interface.h
//  GG
//
//  Created by foj on 14-8-3.
//  Copyright (c) 2014年 GG. All rights reserved.
//


#define kHost_URL @"http://zdbtest.duapp.com"


//上传图片
#define kUploadImage(token) [NSString stringWithFormat:@"%@/api/upload/shopImageUp?token=%@",kHost_URL,token]

//注册
#define kRegister_URL @"http://www.tuanvs.cc/Index/domobileregister"

//登录
#define kLogin_URL(user,password)  [NSString stringWithFormat:@"%@/api/shopAdmin/login?user=%@&pass=%@",kHost_URL,user,password]

//发送验证码
#define kSendVerifyCode_URL(phone) [NSString stringWithFormat:@"%@/api/shopAdmin/sendCode?tel=%@",kHost_URL,phone]
#define KResendCode(phone) [NSString stringWithFormat:@"%@/api/shopAdmin/resendCode?tel=%@",kHost_URL,phone]


//验证验证码
#define kCheckCode(tel,code) [NSString stringWithFormat:@"%@/api/shopAdmin/checkCode?tel=%@&code=%@",kHost_URL,tel,code]

#define KRecheckCode(tel,code) [NSString stringWithFormat:@"%@/api/shopAdmin/recheckCode?tel=%@&code=%@",kHost_URL,tel,code]

//设置密码
#define kSetPassword(tel,code,pass) [NSString stringWithFormat:@"%@/api/shopAdmin/setPass?tel=%@&code=%@&pass=%@",kHost_URL,tel,code,pass]
#define kResetPassword(tel,code,pass) [NSString stringWithFormat:@"%@/api/shopAdmin/resetPass?tel=%@&code=%@&pass=%@",kHost_URL,tel,code,pass]

//修改密码
#define KUpdatePassword(old_pass,new_pass) [NSString stringWithFormat:@"%@/api/shopAdmin/alterPass?old_pass=%@&new_pass=%@",kHost_URL,old_pass,new_pass]

//|给用户发私信

#define KSendPM(token,user_id,content) [NSString stringWithFormat:@"%@/api/shopAdmin/sendMsg?token=%@&user_id=%@&content=%@",kHost_URL,token,user_id,content]

//创建店铺（经度，纬度，图标）
#define KCreateShop(token,name,longitude,latitude,url) [NSString stringWithFormat:@"%@/api/shop/createShop?token=%@&name=%@&longitude=%f&latitude=%f&url=%@",kHost_URL,token,name,longitude,latitude,url]

//已登录店铺详情
#define kShopDetail(token) [NSString stringWithFormat:@"%@/api/shop/selfContent?token=%@",kHost_URL,token]

//|店铺粉丝，所有关注我店铺的用户
#define KFans(token) [NSString stringWithFormat:@"%@/api/shop/fans?token=%@",kHost_URL,token]

//：收到的用户发来的私信列表
#define kPMList(token,page) [NSString stringWithFormat:@"%@/api/shop/msgList?token=%@&page=%d&offset=10",kHost_URL,token,page]
//已登录商店的所有商品的评论
#define kAll_Comment(token) [NSString stringWithFormat:@"%@/api/shop/allComment?token=%@",kHost_URL,token]

//商品列表
#define kGoodsListURL(page,shop_id) [NSString stringWithFormat:@"%@/api/goods/list?offset=%d&rows=10&shop_id=%@",kHost_URL,page,shop_id]


