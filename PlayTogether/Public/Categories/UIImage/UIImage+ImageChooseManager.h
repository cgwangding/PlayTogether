//
//  UIImage+ImageChooseManager.h
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/5.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (ImageChooseManager)<UIActionSheetDelegate>

+ (void)imageChooseWithController:(UIViewController*)controller;

@end
