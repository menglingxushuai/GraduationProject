//
//  Detail2SubViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "Detail2SubViewController.h"
#import "FMProgrameModel.h"
#import "SegDetailCell.h"
@interface Detail2SubViewController ()<UITableViewDelegate,UITableViewDataSource, DetailCellDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) FMProgrameModel *model;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat keywordsHeight;

@end

@implementation Detail2SubViewController


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
    self.view.backgroundColor = WhiteColor;
    [self loadDetailData];
}


- (void)loadDetailData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@", FM_SegDetail_BaseUrl, self.ID, FM_SegDetail_AppendUrl];
    [MBProgressHUD setUpGifShowToView:self.view];
    __weak typeof(self) weakSelf = self;
    [[BSRequestHandle shareBSRequestHandle] getURL:urlStr parameters:nil succsess:^(id responseObject) {
        
        NSDictionary *resultDic = responseObject[@"result"];
        if (resultDic != nil) {
            
            FMProgrameModel *model = [FMProgrameModel new];
            [model setValuesForKeysWithDictionary:resultDic];
            weakSelf.model = model;
        }
        
            [self.tableview.mj_footer endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableview reloadData];
        
    } failed:^(id error) {
        
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 130;
            break;
        case 1:
            if (self.keywordsHeight) {
                return self.keywordsHeight;
            } else {
                return 100;
            }
            break;
        case 2:
            if (self.height) {
                return self.height;
            } else {                
                return 100;
            }
            break;
        case 3:
            return (kWindowWidth - 40) / 3 + 51;
            break;
    }
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath.row) {
        case 0:
            identifier = @"0";
            index = 0;
            break;
        case 1:
            identifier = @"1";
            index = 1;
            break;
        case 2:
            identifier = @"2";
            index = 2;
            break;
        case 3:
            identifier = @"3";
            index = 3;
            break;
            
        default:
            break;
    }
    
    SegDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SegDetailCell" owner:self options:nil] objectAtIndex:index];
    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.detaileDelegate = self;
    }
    [cell bindModel:self.model atIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)heightOfCell:(CGFloat)height {
    self.height = height;
    
}

- (void)heightOfCellKeywords:(CGFloat)height {
    self.keywordsHeight = height + 10;
}

@end
