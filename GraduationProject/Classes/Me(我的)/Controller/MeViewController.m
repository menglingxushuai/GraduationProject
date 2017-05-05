//
//  MeViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "MeViewController.h"
#import "TitleImgCell.h"
#import "LoginOutCell.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource, LoginOutCellDelegete>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
}

- (void)initLayout {
    self.view.backgroundColor = WhiteColor;
    self.title = @"我";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleImgCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginOutCell" bundle:nil] forCellReuseIdentifier:@"OutCell"];
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:{
            TitleImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            return cell;
            break;
        }
        case 1:{
            
            cell.textLabel.text = @"我的下载";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;            return cell;
        }
        case 2:{
            
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = @"30M";
            return cell;
        }
        case 3:{
            LoginOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutCell" forIndexPath:indexPath];
            [cell.loginOut setTitle:@"立即登录" forState:UIControlStateNormal];
            cell.outdelegate = self;
            return cell;
        }
        default:{
            return cell;
            break;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    } else if (indexPath.row == 3) {
        return 60;
    } else {
        return 40;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}



- (void)logOut:(UIButton*)btn {
    DLog(@"退出登录");
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
