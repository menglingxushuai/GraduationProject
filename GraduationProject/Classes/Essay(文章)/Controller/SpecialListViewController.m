//
//  SpecialListViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/4.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "SpecialListViewController.h"
#import "NewsPhotoSetCell.h"
#import "NewsArticleCell.h"
#import "EssayDetailViewController.h"
#import "PhotoDetailViewController.h"
typedef NS_ENUM(NSUInteger, NewsType) {
    NewsTypePhotoSet,
    NewsTypeSpecial,
    NewsTypeArticle,
    NewsTypeUnknow,
};

@interface SpecialListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;

@end

@implementation SpecialListViewController

- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

-(UITableView *)tableview{
    
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight) style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleViewSet];
    [self loadData];
    
}

- (void)titleViewSet {
    self.title = @"列表";
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"navigationButtonReturn-1" highImage:nil target:self action:@selector(back)];
    
    // 注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"NewsPhotoSetCell" bundle:nil] forCellReuseIdentifier:@"NewsPhotoSetCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"NewsArticleCell" bundle:nil] forCellReuseIdentifier:@"NewsArticleCell"];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
    __weak typeof(self)weakSelf = self;
    [[BSRequestHandle shareBSRequestHandle] getURL:Essay_SPECIAL_DETAIL_URL(self.news.skipID) parameters:nil succsess:^(id responseObject) {
        NSArray *resultArr = [responseObject[weakSelf.news.skipID][@"topics"] firstObject][@"docs"];
        for (NSDictionary *dict in resultArr) {
            News *news = [[News alloc] init];
            [news setValuesForKeysWithDictionary:dict];
            if ([weakSelf newsTypeWithNews:news] != NewsTypeUnknow) {
                [weakSelf.allArray addObject:news];
            }
        }
        
        [weakSelf.tableview reloadData];
        
    } failed:^(id error) {
        
    }];
}

#pragma mark - 返回新闻类型
- (NewsType)newsTypeWithNews:(News *)news {
    if (news.skipType == nil) {
        return NewsTypeArticle;
    } else if ([news.skipType isEqualToString:@"special"]) {
        return NewsTypeSpecial;
    } else if ([news.skipType isEqualToString:@"photoset"]) {
        return NewsTypePhotoSet;
    }
    return NewsTypeUnknow;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    News *news = self.allArray[indexPath.row];
    switch ([self newsTypeWithNews:news]) {
        case NewsTypePhotoSet:{
            NewsPhotoSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsPhotoSetCell" forIndexPath:indexPath];
            [cell bindData:news];
            return cell;
            break;
        }
        case NewsTypeArticle:{
            NewsArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsArticleCell" forIndexPath:indexPath];
            [cell bindData:news];
            return cell;
            break;
        }
        case NewsTypeSpecial:{
            NewsArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsArticleCell" forIndexPath:indexPath];
            [cell bindData:news];
            return cell;
        }
        case NewsTypeUnknow:{
            break;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.allArray[indexPath.row];
    if ([self newsTypeWithNews:news] == NewsTypePhotoSet) {
        return 150;
    } else {
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.allArray[indexPath.row];
    switch ([self newsTypeWithNews:news]) {
        case NewsTypeArticle:{
            EssayDetailViewController *DetailVC = [[EssayDetailViewController alloc] init];
            DetailVC.model = news;
            DetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:DetailVC animated:YES];
            break;
        }
        case NewsTypePhotoSet:{
            PhotoDetailViewController *VC = [[PhotoDetailViewController alloc] init];
            VC.news = news;
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            break;
        }
        case NewsTypeSpecial:{
            SpecialListViewController *Vc = [SpecialListViewController new];
            Vc.news = news;
            Vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Vc animated:YES];
            
            break;
        }
        case NewsTypeUnknow:{
            break;
        }

    }
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
