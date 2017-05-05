//
//  NewsArticleCell.m
//  ShowNews
//
//  Created by ZZQ on 16/6/24.
//  Copyright © 2016年 YZZL. All rights reserved.
//

#import "NewsArticleCell.h"
#import "UIImageView+WebCache.h"

@interface NewsArticleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;


@end

@implementation NewsArticleCell

- (void)bindData:(News *)news {
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    self.titlelabel.text = news.title;
    self.sourceLabel.text = news.source;
    if ([news.skipType isEqualToString:@"special"]) {
        _typeLabel.hidden = NO;
    } else {
        _typeLabel.hidden = YES;
    }
}

@end
