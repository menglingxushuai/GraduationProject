//
//  FMViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "FMViewController.h"
#import "SubViewController.h"
#import "FMTitleModel.h"
@interface FMViewController ()
// 大数组
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) NSMutableArray *allTitleArray;

@end

@implementation FMViewController


- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

- (NSMutableArray *)allTitleArray
{
    if (!_allTitleArray) {
        _allTitleArray = [NSMutableArray array];
    }
    return _allTitleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];
    [self loadFMData];
    
}


// 初始化布局
- (void)initLayout {
    self.title = @"FM";
    self.navigationController.navigationBar.translucent = NO;
}

// 请求数据
- (void)loadFMData {
    [MBProgressHUD setUpGifShowToView:self.view];
    // 弱引用
    __weak typeof(self) weakSelf = self;
    [[BSRequestHandle shareBSRequestHandle] postURL:FM_URL parameters:nil succsess:^(id responseObject) {
        
        NSDictionary *resultDic = responseObject[@"result"];
        if (resultDic != nil) {
            NSArray *dataArr = resultDic[@"dataList"];
            if (ArrayHave(dataArr)) {
                for (NSDictionary *dic in dataArr) {
                    FMTitleModel *model = [FMTitleModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.allArray addObject:model];
                    [weakSelf.allTitleArray addObject:model.categoryName];
                }
            }
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self setMenuController];
        
    } failed:^(id error) {
        
    }];
}

- (void)setMenuController {
    self.selectColor = RGB(82, 203, 203);
    [self initializeLinkageListViewController];
}

- (void)addChildViewController{
    
    self.vcTitleArr = self.allTitleArray;
    if (ArrayHave(self.vcTitleArr)) {

        for (int i = 0; i < self.vcTitleArr.count; i++) {
            
            FMTitleModel *model = self.allArray[i];
            SubViewController * vc = [[SubViewController alloc] init];
            vc.title  =  self.vcTitleArr[i];
            vc.categoryId = model.categoryId;
            [self addChildViewController:vc];
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
