

#import "SubViewController.h"
#import "FMDetailModel.h"
#import "FmDetailCell.h"
#import "DetailFMController.h"
@interface SubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;
@end

@implementation SubViewController

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
    [self initLayout];
    [self loadDetailData];
//    [self setupRefesh];
}

- (void)initLayout {
    self.view.backgroundColor = WhiteColor;
    [self.view addSubview:self.tableview];
    [self.tableview registerNib:[UINib nibWithNibName:@"FmDetailCell" bundle:nil] forCellReuseIdentifier:@"FmCell"];
}

- (void)setupRefesh {
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDetailData)];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_header.automaticallyChangeAlpha = YES;
    self.tableview.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
}

- (void)loadNewData {
    [self.tableview.mj_footer endRefreshing];
}


- (void)loadDetailData {
    [self.allArray removeAllObjects];
    [MBProgressHUD setUpGifShowToView:self.view];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@", FM_Detail_BaseUrl, self.categoryId, FM_Detail_AppendingUrl];
    // 弱引用
    __weak typeof(self) weakSelf = self;
    [[BSRequestHandle shareBSRequestHandle] postURL:urlStr parameters:nil succsess:^(id responseObject) {
        
        NSDictionary *resultDic = responseObject[@"result"];
        if (resultDic != nil) {
            NSArray *dataArr = resultDic[@"dataList"];
            if (ArrayHave(dataArr)) {
                for (NSDictionary *dic in dataArr) {
                    FMDetailModel *model = [FMDetailModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.allArray addObject:model];
                }
            }
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableview.mj_header endRefreshing];
        [self.tableview reloadData];
        
    } failed:^(id error) {
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.allArray.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FMDetailModel *model = self.allArray[indexPath.row];
    FmDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FmCell" forIndexPath:indexPath];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMDetailModel *model = self.allArray[indexPath.row];
    DetailFMController *vc = [[DetailFMController alloc] init];
    vc.ID = model.Id;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
