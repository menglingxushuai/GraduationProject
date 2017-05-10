//
//  EssayViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "EssayViewController.h"
#import "News.h"
#import "NewsArticleCell.h"
#import "FirstCell.h"
#import "EssayDetailViewController.h"
#import "SpecialListViewController.h"
#import "PhotoDetailViewController.h"

typedef NS_ENUM(NSUInteger, NewsType) {
    NewsTypePhotoSet,
    NewsTypeSpecial,
    NewsTypeArticle,
    NewsTypeUnknow,
};

@interface EssayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;

@end

static int page = 0;

@implementation EssayViewController

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
    [self initLayout];
    [self loadEssayData];
    [self setupRefesh];

}

- (void)setupRefesh {
    
    self.tableview.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
}

- (void)loadNewData {
    page +=20;
    [self loadEssayData];
    [self.tableview.mj_footer endRefreshing];
}


- (void)initLayout {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"文章";
    // 注册tableViewCell
    [self.tableview registerNib:[UINib nibWithNibName:@"NewsArticleCell" bundle:nil] forCellReuseIdentifier:@"NewsArticleCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FirstCell" bundle:nil] forCellReuseIdentifier:@"firstCell"];
}

- (void)loadEssayData {
    [MBProgressHUD setUpGifShowToView:self.view];
    [[BSRequestHandle shareBSRequestHandle] getURL:[NSString stringWithFormat:@"%@%d-%d.html", Essay_Url, page, page + 20] parameters:nil succsess:^(id responseObject) {
        NSArray *resultArr = responseObject[@"T1348649580692"];
        if (ArrayHave(resultArr)) {
            for (NSDictionary *resultDict in resultArr) {
                News *news = [[News alloc] init];
                [news setValuesForKeysWithDictionary:resultDict];
                if ([self newsTypeWithNews:news] != NewsTypeUnknow) {
                    [self.allArray addObject:news];
                }
            }
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableview reloadData];
        
    } failed:^(id error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.allArray[indexPath.row];
    
    if (indexPath.row == 0) {
        FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        cell.model = news;
        return cell;
    } else {
        NewsArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsArticleCell" forIndexPath:indexPath];
        [cell bindData:news];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 150;
    } else {        
        return 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.allArray[indexPath.row];
    if ([news.skipType isEqualToString:@"special"]) {
        SpecialListViewController *specialVc = [SpecialListViewController new];
        specialVc.news = news;
        specialVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:specialVc animated:YES];
    } else if ([news.skipType isEqualToString:@"photoset"]) {
        PhotoDetailViewController *vc = [PhotoDetailViewController new];
        vc.news = news;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        EssayDetailViewController *detailVc = [EssayDetailViewController new];
        detailVc.model = news;
        detailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVc animated:YES];

    }
    
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
