//
//  MyIssueVideoViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/8.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "MyIssueVideoViewController.h"
#import "LocationPlayCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "AlumniVideoViewController.h"
@interface MyIssueVideoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    AVPlayer *player;
}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;
@end

@implementation MyIssueVideoViewController
- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    [self getMyData];

}

- (void)initLayout {
    
    self.title = @"校友发布";
    self.view.backgroundColor = WhiteColor;
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight) style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    [self.tableview registerNib:[UINib nibWithNibName:@"LocationPlayCell" bundle:nil] forCellReuseIdentifier:@"LPCell"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"navigationButtonReturn-1" highImage:nil target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getMyData {
    AVQuery *query = [AVQuery queryWithClassName:@"_File"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (ArrayHave(objects)) {
                self.allArray = objects.mutableCopy;
                [self.tableview reloadData];
            }
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPCell" forIndexPath:indexPath];
    NSDictionary *dic = self.allArray[indexPath.row];
    cell.MyTitle.text =  dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.allArray[indexPath.row];
    AlumniVideoViewController *Vc = [AlumniVideoViewController new];
    Vc.videoStr = dic[@"url"];
    [self.navigationController pushViewController:Vc animated:YES];
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
