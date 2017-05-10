//
//  Detail1SubViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "Detail1SubViewController.h"
#import "FMProgrameModel.h"
#import "CommentCell.h"
@interface Detail1SubViewController ()<UITableViewDelegate,UITableViewDataSource, CommentCellDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) CGFloat height;
@end

@implementation Detail1SubViewController
- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

-(UITableView *)tableview{
    
    if(!_tableview){
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight - self.navigationController.navigationBar.frame.size.height - 64 - 44) style:UITableViewStylePlain];
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
    [self.tableview registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CCell"];
    self.view.backgroundColor = WhiteColor;
    self.number = 1;
    [self loadCommentData];
    [self setupRefesh];
}


- (void)setupRefesh {
    
    self.tableview.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCommentData)];
    
}


- (void)loadCommentData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%ld%@", FM_Comment_BaseUrl, self.ID, FM_Comment_AppendNumUrl, self.number, FM_Comment_Last];
    [MBProgressHUD setUpGifShowToView:self.view];
    __weak typeof(self) weakSelf = self;
    [[BSRequestHandle shareBSRequestHandle] getURL:urlStr parameters:nil succsess:^(id responseObject) {
        NSDictionary *resultDic = responseObject[@"result"];
        if (resultDic != nil) {
            NSArray *dataArr = resultDic[@"dataList"];
            if (ArrayHave(dataArr)) {
                for (NSDictionary *dic in dataArr) {
                    FMProgrameModel *model = [FMProgrameModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.allArray addObject:model];
                }
                
            }
        }
        
            self.number++;
            [self.tableview.mj_footer endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableview reloadData];
        
    } failed:^(id error) {
        [self.tableview.mj_footer endRefreshing];

    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.height) {
        return self.height;
    } else {
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.commentDelegate = self;
    
    FMProgrameModel *model = self.allArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)heighOfCell:(CGFloat)heigh {
    self.height = heigh;
    
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
