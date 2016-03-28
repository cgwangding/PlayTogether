

//
//  UIImage+ImageChooseManager.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/5.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "UIImage+ImageChooseManager.h"
#import <objc/runtime.h>

static const char *controllerKey = "controllerKey";

@implementation UIImage (ImageChooseManager)

+ (instancetype)sharedImage
{
    static UIImage *image = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        image = [[UIImage alloc]init];
    });
    return image;
}

+ (void)imageChooseWithController:(UIViewController *)controller
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"照片选择" delegate:[UIImage sharedImage] cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [sheet showInView:controller.view];
    objc_setAssociatedObject([UIImage sharedImage], &controllerKey, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - action

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*controller = objc_getAssociatedObject(self, &controllerKey);
    if (buttonIndex == 0) {
        //拍照
        if ([self isAuthorizetionCamera]) {
            [self startCarmeraWithController:controller];
        }
    }
    if (buttonIndex == 1) {
        if ([self isAuthorizetionPhotoLibarary]) {
            [self startPhotoLibararyWithController:controller];
        }
    }
}

#pragma mark - helper

- (BOOL)isAuthorizetionCamera
{
    BOOL isAuth = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未获得授权使用相机" message:@"请在\"设置\"->\"隐私\"->\"相机\"中打开" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        isAuth = YES;
    }
    
    return isAuth;
}

- (BOOL)isAuthorizetionPhotoLibarary
{
    BOOL isAuth = NO;
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus == ALAuthorizationStatusDenied || authStatus == ALAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未获得授权使用相册" message:@"请在\"设置\"->\"隐私\"->\"照片\"中打开" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        isAuth = YES;
    }
    
    return isAuth;
}

#pragma mark - MessageToolViewDelegate method helper
- (void)startCarmeraWithController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)controller
{
    if (![InCommonUse isDeviceCameraAvailable]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"相机不可用" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = controller;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8) {
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [controller presentViewController:picker animated:YES completion:nil];
}

- (void)startPhotoLibararyWithController:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>*)controller
{
    if (![InCommonUse isPhotoLibraryAvailable]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"相册不可用" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = controller;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8) {
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [controller presentViewController:picker animated:YES completion:nil];
}


@end
