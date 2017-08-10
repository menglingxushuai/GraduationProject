//
//  AlumnusIssueViewController.m
//  GraduationProject
//
//  Created by 孟令旭 on 2017/6/4.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "AlumnusIssueViewController.h"
#import "AlumDetailViewController.h"
@interface AlumnusIssueViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;

@end

@implementation AlumnusIssueViewController
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
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章";
    self.view.backgroundColor = WhiteColor;
    [self.view addSubview:self.tableview];
    
    [self loadData];
}

- (void)loadData {
    AVQuery *query = [AVQuery queryWithClassName:@"Todo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (ArrayHave(objects)) {
                self.allArray = objects.mutableCopy;
                DLog(@"%@", self.allArray);
                
                [self.tableview reloadData];
            }
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic = self.allArray[indexPath.row];
    NSString *string = dic[@"WZ"];
    cell.textLabel.text = [self titleStringWithStr:string];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.allArray[indexPath.row];
    NSString *string = dic[@"WZ"];
    AlumDetailViewController *Vc = [AlumDetailViewController new];
    Vc.bodyStr = string;
    [self.navigationController pushViewController:Vc animated:YES];
}


- (NSString *)titleStringWithStr:(NSString *)string {
    NSArray *arr = [string componentsSeparatedByString:@"</h3>"];
    NSArray *arrLast = [arr[0] componentsSeparatedByString:@">"];
    return [arrLast lastObject];
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
