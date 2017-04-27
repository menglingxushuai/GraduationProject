//
//  BiShe_Sinleton.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#ifndef BiShe_Sinleton_h
#define BiShe_Sinleton_h

// 单例声明
#define singleton_interface(className) \
+ (instancetype)share##className;

// 单例实现
#define singletion_implementation(className) \
static className *manager; \
+ (instancetype)share##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
manager = [[[self class] alloc] init]; \
}); \
return manager; \
}


#endif /* BiShe_Sinleton_h */
