//
//  OSSViewController.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/13.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OSSImgBlock)(NSString *imgUrl);
@interface OSSViewController : UIImagePickerController

@property (nonatomic, copy) OSSImgBlock imgBlock;

@end
