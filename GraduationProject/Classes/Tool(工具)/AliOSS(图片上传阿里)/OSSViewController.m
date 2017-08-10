//
//  OSSViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/13.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "OSSViewController.h"

NSString * const AccessKey = @"LTAIydVsgwJYp5bW";
NSString * const SecretKey = @"IJ88ZmiIy6wfaj0p3cM7dFd7kzp7HO";
@interface OSSViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
    OSSClient * client;
}
@property(nonatomic,strong)NSData *imageData;

@property (nonatomic, strong) UIView *whiteView;
@end

@implementation OSSViewController

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _whiteView.backgroundColor = WhiteColor;
    }
    return _whiteView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.whiteView];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    [actionSheet showInView:self.view];
    
    self.delegate = self;

}


#pragma mark - UIActionSheet的代理 打开相机相册 取消
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.whiteView removeFromSuperview];
    
    switch (buttonIndex) {
        case 0:
        {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    self.allowsEditing = NO;//是否允许编辑
                    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:self];
                    [popover presentPopoverFromRect:CGRectMake(0, 0, 600, 800) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                }];
            } else {
                self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                self.allowsEditing = YES;
            }
            break;
        }
        case 1:
            if (SIMULATOR == 0) {
                self.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.allowsEditing = YES;
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
}


#pragma mark - 获取到image时设置阿里oss上传
- (void)saveImage:(UIImage *)image {
    NSData *sendData = UIImageJPEGRepresentation(image, 0.5f);
    
#warning - 参数设置 -
    NSString *endpoint = @"http://oss-cn-beijing.aliyuncs.com";
    // 明文设置secret的方式建议只在测试时使用，更多鉴权模式参考后面链接给出的官网完整文档的`访问控制`章节
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey
                                                                                                            secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // required fields
#warning 参数设置
    put.bucketName = @"sjvz-image02";
    NSString *objectKeys = [NSString stringWithFormat:@"circle/%@.jpg",[self getTimeNow]];
    
    put.objectKey = objectKeys;
    //put.uploadingFileURL = [NSURL fileURLWithPath:fullPath];
    put.uploadingData = sendData;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
       DLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        task = [client presignPublicURLWithBucketName:@"-------"
                                        withObjectKey:objectKeys];
        DLog(@"objectKey: %@", put.objectKey);
        
        if (!task.error) {
            
            NSString *imgstr  = [NSString stringWithFormat:@"http://sjvz-image02.oss-cn-beijing.aliyuncs.com/%@",put.objectKey];
//            DLog(@"%@", imgstr);
            self.imgBlock(imgstr);
        } else {
            DLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mamrk - 获取当时时间
- (NSString *)getTimeNow
{
    NSDate *date =[NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setDateFormat:@"HH-mm-ss"];
    NSString *timeNow = [formatter stringFromDate:date];
    DLog(@"%@", timeNow);
    
    return timeNow;
}


@end
