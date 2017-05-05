//
//  DetailTagView.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/2.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "DetailTagView.h"
#import "SFTag.h"
#import "SFTagButton.h"
@implementation DetailTagView

- (void)setArr:(NSArray *)arr {
    _arr = arr;
    self.insets = 10;
    self.lineSpace = 10;
    for (int i = 0; i < _arr.count; i ++) {
        SFTag *sfTag = [[SFTag alloc] initWithText:_arr[i]];
        sfTag.textColor = [UIColor whiteColor];
        sfTag.bgColor = MainColor;
        sfTag.inset = 6;
        sfTag.cornerRadius = 5;
        sfTag.target = self;
//        sfTag.action = @selector(sfTagAction:);
//        sfTag.index = i;
        [self addTag:sfTag];
    }
    SFTagButton *sfTag = [self.subviews lastObject];
    self.sfTag = sfTag;
    
}



@end
