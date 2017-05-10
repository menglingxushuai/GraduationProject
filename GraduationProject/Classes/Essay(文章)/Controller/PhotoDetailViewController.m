//
//  PhotoDetailViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/4.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "NewsImage.h"
@interface PhotoDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bgScroller;
@property (weak, nonatomic) IBOutlet UILabel *setname;
@property (weak, nonatomic) IBOutlet UILabel *imgsum;
@property (weak, nonatomic) IBOutlet UILabel *currentSum;
@property (weak, nonatomic) IBOutlet UILabel *note;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleViewSet];
    [self loadPhotoData];
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)titleViewSet {
    self.title = @"详情";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"navigationButtonReturn-1" highImage:nil target:self action:@selector(back)];
    self.bgScroller.delegate = self;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载数据
- (void)loadPhotoData {
    __weak typeof(self)weakSelf = self;
    NSArray *skipArray = [self.news.skipID componentsSeparatedByString:@"|"];
    if (ArrayHave(skipArray)) {
        NSString *urlStr = Essay_PHOTOSET_DETAIL_URL([skipArray[0] substringFromIndex:4], skipArray[1]);
        [[BSRequestHandle shareBSRequestHandle] getURL:urlStr parameters:nil succsess:^(id responseObject) {
            [weakSelf.news setValuesForKeysWithDictionary:responseObject];
            weakSelf.news.photos = [NSMutableArray array];
            NSArray *arr = responseObject[@"photos"];
            if (ArrayHave(arr)) {
                for (NSDictionary *dic in arr) {
                    NewsImage *newsImage = [NewsImage new];
                    [newsImage setValuesForKeysWithDictionary:dic];
                    [weakSelf.news.photos addObject:newsImage];
                }
            }
            
            [self setContent];
            
        } failed:^(id error) {
            
        }];
    }
}


#pragma mark - 设置图片文字 滑动
- (void)setContent {
    self.setname.text = self.news.setname;
    self.imgsum.text = [NSString stringWithFormat:@"/%@",self.news.imgsum];
    self.bgScroller.contentSize = CGSizeMake(kWindowWidth*[self.news.imgsum integerValue], 0);
    NewsImage *newsImage = self.news.photos[0];
    self.note.text = newsImage.note;
    for (int i = 0; i < self.news.photos.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kWindowWidth*i, -64, kWindowWidth, self.bgScroller.height)];
        NewsImage *newsImage = self.news.photos[i];
        [img sd_setImageWithURL:[NSURL URLWithString:newsImage.imgurl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        [self.bgScroller addSubview:img];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = self.bgScroller.contentOffset.x / kWindowWidth;
    NewsImage *newsImage = self.news.photos[index];
    self.note.text = newsImage.note;
    self.currentSum.text = [NSString stringWithFormat:@"%ld", index + 1];
}

#warning 重回image的大小让其等于imageView的大小 （暂时未用到）
-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize
                                                     )size

{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [image
     drawInRect:CGRectMake(0,0, size.width, size.height
                           )];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext
    ();
    UIGraphicsEndImageContext
    ();
        return scaledImage;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
