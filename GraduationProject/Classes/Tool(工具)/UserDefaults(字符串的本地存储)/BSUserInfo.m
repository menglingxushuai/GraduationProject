//
//  BSUserInfo.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSUserInfo.h"

@implementation BSUserInfo
+ (void)saveDataWithKey:(NSString*)key forData:(NSString*)data{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    
    
    
}

+ (NSString*)getDataWithKey:(NSString*)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:key];
    
    
}
+ (void)removeData:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
}



@end
