//
//  SegDetailCell.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/2.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMProgrameModel;
@class DetailTagView;
@protocol DetailCellDelegate <NSObject>

- (void)heightOfCell:(CGFloat)height;
- (void)heightOfCellKeywords:(CGFloat)height;


@end
@interface SegDetailCell : UITableViewCell
/// 0
@property (weak, nonatomic) IBOutlet UILabel *anchor;
@property (weak, nonatomic) IBOutlet UILabel *where;
@property (weak, nonatomic) IBOutlet UILabel *uploading;
@property (weak, nonatomic) IBOutlet UILabel *stadus;
/// 1
@property (weak, nonatomic) IBOutlet UILabel *keywords;
/// 2
@property (weak, nonatomic) IBOutlet UILabel *intro;
/// 3
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLine;
- (void)bindModel:(FMProgrameModel *)model atIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, weak) id<DetailCellDelegate>detaileDelegate;
@property (nonatomic, weak) IBOutlet DetailTagView *tagView;
@end
