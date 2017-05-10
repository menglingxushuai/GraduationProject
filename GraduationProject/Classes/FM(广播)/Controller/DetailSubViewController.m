//
//  DetailSubViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "DetailSubViewController.h"
#import "FMProgrameModel.h"
#import "ProgramCell.h"
#import "FMPlayerViewController.h"
@interface DetailSubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, assign)NSInteger number;
@end

@implementation DetailSubViewController

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
        [_tableview registerNib:[UINib nibWithNibName:@"ProgramCell" bundle:nil] forCellReuseIdentifier:@"PCell"];
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.number = 1;
    [self loadProgrameData];
    [self setupRefesh];
}

- (void)setupRefesh {
    
    self.tableview.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadProgrameData)];
    
}



- (void)loadProgrameData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%ld%@", FM_Programe_BaseUrl, self.ID, FM_Programe_AppendNumUrl, self.number, FM_Programe_Last];
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableview.mj_footer endRefreshing];
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
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FMProgrameModel *model = self.allArray[indexPath.row];
    ProgramCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPlayerViewController *Vc = [FMPlayerViewController new];
    Vc.index = indexPath.row;
    Vc.allArr = self.allArray;
    Vc.ID = self.ID;
    [self.navigationController pushViewController:Vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
