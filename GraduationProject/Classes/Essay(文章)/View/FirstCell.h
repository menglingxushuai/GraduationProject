//
//  FirstCell.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/4.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;
@interface FirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) News *model;
@end
