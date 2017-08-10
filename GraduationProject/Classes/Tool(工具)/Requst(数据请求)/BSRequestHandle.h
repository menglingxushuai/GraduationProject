//
//  BSRequestHandle.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRequestHandle : NSObject

singleton_interface(BSRequestHandle);


- (void)postURL:(NSString*)url parameters:(id)parameter succsess:(void(^)(id responseObject))success failed:(void(^)(id error))failed;

- (void)getURL:(NSString*)url parameters:(id)parameter succsess:(void(^)(id responseObject))success failed:(void(^)(id error))failed;


@end
