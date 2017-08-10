//
//  VideoViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoMainCell.h"
#import "VideoDetailController.h"
#import "VideoModel.h"
#import "MyIssueVideoViewController.h"
#import "AlumnusIssueViewController.h"
@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;

@end

@implementation VideoViewController

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
    
    
}


- (void)initLayout {
    self.title = @"校友发布";
    self.view.backgroundColor = WhiteColor;
    [self.view addSubview:self.tableview];
    [self.tableview registerNib:[UINib nibWithNibName:@"VideoMainCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kWindowHeight - 64 - 49)*0.5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];

    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"牧羊人%ld", indexPath.row + 1]];
    switch (indexPath.row) {
        case 0:
            cell.nameLabel.text = @"发布的视频";
            break;
            
        default:
            cell.nameLabel.text = @"发布的文章";
            break;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{
            MyIssueVideoViewController *vc = [MyIssueVideoViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:{
            AlumnusIssueViewController *Vc = [AlumnusIssueViewController new];
            [self.navigationController pushViewController:Vc animated:YES];
            break;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
