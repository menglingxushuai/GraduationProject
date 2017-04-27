//
//  NSString+IsBlank.m
//  FamlMedical_Doctor
//
//  Created by MacBook on 2016/12/6.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "NSString+IsBlank.h"

@implementation NSString (IsBlank)
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
