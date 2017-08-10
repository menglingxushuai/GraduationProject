//
//  LocationDownloadViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "LocationDownloadViewController.h"
#import "LocationPlayCell.h"
#import "AVPlayerManager.h"
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSUInteger, isPlay) {
    Play,
    Pause,
};

@interface LocationDownloadViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    isPlay _isplay;
}

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIImageView *currentImg;

@end

@implementation LocationDownloadViewController
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
    [self loadLocationDownload];
}

- (void)initLayout {
    _isplay = Pause;

    self.title = @"我的下载";
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


#pragma mark - 获取本地数据
- (void)loadLocationDownload {
    
    NSString *documentDirectory = [self getDocumentPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *array =   [manager contentsOfDirectoryAtPath:documentDirectory error:nil];
    for (NSString *str in array) {
        if ( [str rangeOfString:@".mp3"].location != NSNotFound){
            [self.allArray addObject:str];
        }
    }
    
    [self.tableview reloadData];
}

- (NSString *)getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
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
    cell.MyTitle.text = self.allArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *documentDirectory = [self getDocumentPath];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", documentDirectory, self.allArray[indexPath.row]];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    LocationPlayCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    _currentImg.image = [UIImage imageNamed:@"playLocation"];
    if (_isplay == Pause) {
        _isplay = Play;
        if ([AVPlayerManager shareAVPlayerManager].status == isPlaying) {
            [[AVPlayerManager shareAVPlayerManager] stop];
        }
        _player = [[AVPlayer alloc] initWithURL:fileURL];
        [_player play];
        cell.MyImg.image = [UIImage imageNamed:@"pauseLocation"];
        _currentImg =  cell.MyImg;
    } else {
        [_player pause];
        _isplay = Pause;
        cell.MyImg.image = [UIImage imageNamed:@"playLocation"];
        _currentImg =  cell.MyImg;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [_player pause];
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
