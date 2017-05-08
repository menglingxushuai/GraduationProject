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
#import "BSLoginAndRegistViewController.h"
#import "LocationDownloadViewController.h"
#import "MyIssueVideoViewController.h"

#if TARGET_IPHONE_SIMULATOR

#define SIMULATOR 1

#elif TARGET_OS_IPHONE

#define SIMULATOR 0

#endif

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource, LoginOutCellDelegete, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *isLogin;
@property (nonatomic, strong) AVUser *currentUser;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation MeViewController



- (void)viewWillAppear:(BOOL)animated {
    [self statusResult];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
}

#pragma mark - 判断状态:是否登录
- (void)statusResult {
    NSString *isLogin = [BSUserInfo getDataWithKey:@"IsLogin"];
    self.isLogin = isLogin;
    [self.tableView reloadData];
}

#pragma mark - 初始化布局
- (void)initLayout {
    self.view.backgroundColor = WhiteColor;
    self.title = @"我";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleImgCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginOutCell" bundle:nil] forCellReuseIdentifier:@"OutCell"];
    [self.view addSubview:self.tableView];
    
    // 相机相册
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
}


#pragma mark - tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:{
            TitleImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            
            if ([self.isLogin isEqualToString:@"Yes"]) {
                cell.name.text = [BSUserInfo getDataWithKey:@"UserName"];
                AVUser *currentUser = [AVUser currentUser];
                NSData *data = [currentUser objectForKey:@"headImage"];
                if (data) {
                    cell.img.image = [UIImage imageWithData:data];
                } else {
                    cell.img.image = [UIImage imageNamed:@"user_photo"];
                }
            } else {
                cell.name.text = @"未设置";
                cell.img.image = [UIImage imageNamed:@"user_photo"];
            }
            return cell;
            break;
        }
        case 1:{
            
            cell.textLabel.text = @"我的下载";
            cell.detailTextLabel.text = @"";

            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        case 2:{
            
            cell.textLabel.text = @"校友发布";
            cell.detailTextLabel.text = @"";
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            
        case 3:{
            
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM", [ToolForRubbish getDiskSize]];
            return cell;
        }
        case 4:{
            LoginOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutCell" forIndexPath:indexPath];
            if ([NSString isBlankString:self.isLogin] == NO && [self.isLogin isEqualToString:@"Yes"]) {
                [cell.loginOut setTitle:@"退出登录" forState:UIControlStateNormal];
            } else {
                [cell.loginOut setTitle:@"立即登录" forState:UIControlStateNormal];
            }
            
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
    } else if (indexPath.row == 4) {
        return 60;
    } else {
        return 40;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([NSString isBlankString:self.isLogin] == NO && [self.isLogin isEqualToString:@"Yes"]) {
        DLog(@"该干啥干啥");
        switch (indexPath.row) {
            case 0:{
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
                [actionSheet showInView:self.view];
                break;
            }
            case 1:{
                LocationDownloadViewController *vc = [LocationDownloadViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2:{
                MyIssueVideoViewController *vc = [MyIssueVideoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3:{
                [self clearHc];

                break;
            }
            default:
                break;
        }
    } else {
        [self goToLogin];
    }
}


#pragma mark - 清除缓存
- (void)clearHc {
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"提示" message:@"大王!要清理缓存么?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ToolForRubbish clearDisk];
        [self.tableView reloadData];
    }];
    [alerController addAction:action];
    [alerController addAction:action1];
    [self presentViewController:alerController animated:YES completion:nil];
}


#pragma mark - 退出我登录的跳转方法
- (void)logOut:(UIButton*)btn {
    btn.isIgnore = YES;
    if ([btn.titleLabel.text isEqualToString:@"立即登录"]) {
        [self goToLogin];
    } else {
        [AVUser logOut];
        [BSUserInfo saveDataWithKey:@"IsLogin" forData:@"NO"];
        [self statusResult];
    }
}

- (void)goToLogin{
    BSLoginAndRegistViewController *loginVc = [BSLoginAndRegistViewController new];
    [self presentViewController:loginVc animated:YES completion:nil];
}

#pragma mark - UIActionSheet的代理 打开相机相册 取消
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    _imagePicker.delegate = self;
                    _imagePicker.allowsEditing = NO;//是否允许编辑
                    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:_imagePicker];
                    [popover presentPopoverFromRect:CGRectMake(0, 0, 600, 800) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                }];
            } else {
                _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                _imagePicker.allowsEditing = YES;
                [self presentViewController:_imagePicker animated:YES completion:nil];
            }
            break;
        }
        case 1:
            if (SIMULATOR == 0) {
                _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                _imagePicker.allowsEditing = YES;
                [self presentViewController:_imagePicker animated:YES completion:nil];
            }
            break;
        default:
            break;
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    } else {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    
    [self saveImage:image];
    // 如果是相机
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, @selector(saveImage:), nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)saveImage:(UIImage *)image {
    NSData *sendData = UIImageJPEGRepresentation(image, 0.5f);

    [[AVUser currentUser] setObject:sendData forKeyedSubscript:@"headImage"];
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"##########%@", error);
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
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
