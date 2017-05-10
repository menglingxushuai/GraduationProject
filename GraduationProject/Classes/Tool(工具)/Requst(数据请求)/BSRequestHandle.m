//
//  BSRequestHandle.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSRequestHandle.h"

@implementation BSRequestHandle

singletion_implementation(BSRequestHandle);

- (AFHTTPSessionManager *)manager {
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t  onceToken ;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    
    return  manager;
}


- (void)postURL:(NSString *)url parameters:(id)parameter succsess:(void (^)(id))success failed:(void (^)(id))failed {
    
    [[self manager] POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
    
}
- (void)getURL:(NSString *)url parameters:(id)parameter succsess:(void (^)(id))success failed:(void (^)(id))failed {
    
    [[self manager] GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(error);
    }];
    
    
}


@end
