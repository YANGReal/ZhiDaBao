//
//  NBNetworkEngine.m
//  iCareer
//
//  Created by YANGRui on 14-2-27.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "NBNetworkEngine.h"



@implementation NBNetworkEngine

+ (void)loadDataWithURL:(NSString *)url params:(NSDictionary *)params completeHander:(CompleteHander)callBack
{
    if (![AppUtility isNetworkAvaliable])
    {
        return ;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (params == nil||params.count <= 0)
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
             callBack(responseObject,YES);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            callBack(nil,NO);
            
        }];
        return;
    }
  
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        callBack(responseObject,YES);
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        callBack(nil,NO);
    }];
}



+ (void)loadDataWithURL:(NSString *)url completeHander:(CompleteHander)callBack
{
    [NBNetworkEngine loadDataWithURL:url params:nil completeHander:callBack];
}

+(void)uploadImageWithURL:(NSString *)url params:(NSDictionary *)params filePath:(NSString *)path completeHander:(CompleteHander)callBack
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
   // DLog(@"path = %@",path);
    AFHTTPRequestOperation *op = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        
        [formData appendPartWithFileURL:fileURL name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg" error:&error];
      //  formData appendPartWithFileData:<#(NSData *)#> name:<#(NSString *)#> fileName:<#(NSString *)#> mimeType:<#(NSString *)#>
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callBack(responseObject,YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];

    
}

@end
