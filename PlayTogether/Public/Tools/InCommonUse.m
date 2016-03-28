//
//  InCommonUse.m
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/19.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import "InCommonUse.h"
#import "MBProgressHUD.h"
#import "FeHourGlass.h"
#import <CommonCrypto/CommonDigest.h>

@interface InCommonUse()

@property (nonatomic, strong) FeHourGlass *hourGlass;

@end

@implementation InCommonUse

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static InCommonUse *use = nil;
    dispatch_once(&onceToken, ^{
        use = [[InCommonUse alloc]init];
    });
    return use;
}

+ (UIImage *)getGaussianBlurImage:(UIImage *)image
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [[CIImage alloc]initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:@0.5f forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

+ (void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

+ (void)showServerError:(NSInteger)code
{
    NSString *message = nil;
    switch (code) {
        case 404:
            message = @"找不到服务器";
            break;
            
        default:
            message = @"网络不给力~~";
            break;
    }
    [self showMessage:message];
}

+ (void)showActivityIndicator
{
    [[self sharedInstance]actIndicatorShow];
}

+ (void)activityIndicatorHide
{
    [[self sharedInstance]actIndicatorHide];
}

- (void)actIndicatorShow
{
    if (!self.hourGlass) {
        FeHourGlass *glass = [[FeHourGlass alloc]initWithView:[UIApplication sharedApplication].keyWindow];
        self.hourGlass = glass;
      
    }
//    self.hourGlass.alpha = 1;
    if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:self.hourGlass]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.hourGlass];
    }else{
        for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
            if ([view isKindOfClass:[FeHourGlass class]]) {
                [view removeFromSuperview];
                break;
            }
        }
        [[UIApplication sharedApplication].keyWindow addSubview:self.hourGlass];
    }
    [self.hourGlass show];
}

- (void)actIndicatorHide
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hourGlass dismiss];
        [self.hourGlass removeFromSuperview];
        self.hourGlass = nil;
//        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.hourGlass.alpha = 0;
//        } completion:^(BOOL finished) {
//
//        }];
    });
}


+ (BOOL)isDeviceCameraAvailable
{
    BOOL cameraAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    return cameraAvailable;
}

+ (BOOL)isDeviceFrontCameraAvailable
{
    BOOL frontCameraAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    return frontCameraAvailable;
}

// 相册是否可用
+ (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

+(BOOL)isDeviceMagnetometerAvailable
{
    //检查指南针 CoreLocation.framework  <CoreLocation/CoreLocation.h>
//    BOOL magnetometerAvailbale = [CLLocationManager headingAvailable];
//    return magnetometerAvailbale;
    return YES;
}

//把字符串进行 MD5 加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    NSLog(@"%@",ret);
    return [ret lowercaseString];
}

+(NSString *)updateTime:(NSString *)paramTime{

    if (paramTime.length==0) {
        return @"";
    }
    NSString *dateStr=paramTime;
    NSCalendar *gregorian = [[ NSCalendar alloc ] initWithCalendarIdentifier : NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute ;
    NSDateFormatter *format=[[ NSDateFormatter alloc ] init ];
    [format setDateFormat : @"yyyy/MM/dd HH:mm:ss" ];
    NSDate *fromdate=[format dateFromString :dateStr];
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromdate];
   // DDLog(@"%lu-%lu-%lu-%lu",[components month],[components day],[components hour],[components minute]);
     NSDateComponents *nowComponets = [gregorian components:unitFlags fromDate:[NSDate date]];
   // DDLog(@"%lu-%lu-%lu-%lu",[nowComponets month],[nowComponets day],[nowComponets hour],[nowComponets minute]);
    
    //返回的时间
    NSInteger year = [components year];
    NSInteger months = [components month];
    NSInteger days = [components day];
    NSInteger minute = [components minute];
    NSInteger hour = [components hour];
    
    //今天的时间
    NSInteger nowMonths = [nowComponets month];
    NSInteger nowDays = [nowComponets day];
    //    NSInteger nowMinute = [nowComponets minute];
    //    NSInteger nowHour = [nowComponets hour];
    NSString *strHour = hour < 10?[NSString stringWithFormat:@"0%lu",(long)hour]:[NSString stringWithFormat:@"%lu",(long)hour];
    NSString *strMinute = minute < 10?[NSString stringWithFormat:@"0%lu",(long)minute]:[NSString stringWithFormat:@"%lu",(long)minute];
      NSString *strMonth = months < 10?[NSString stringWithFormat:@"0%lu",(long)months]:[NSString stringWithFormat:@"%lu",(long)months];
    NSString *strDay = days < 10?[NSString stringWithFormat:@"0%lu",(long)days]:[NSString stringWithFormat:@"%lu",(long)days];
    NSString *strYear = year < 10?[NSString stringWithFormat:@"0%lu",(long)year]:[NSString stringWithFormat:@"%lu",(long)year];
    if (months == nowMonths && days == nowDays) {
        dateStr = [NSString stringWithFormat:@"今天 %@:%@",strHour,strMinute];
    }else if (months == nowMonths && (nowDays - days == 1)){
        dateStr = [NSString stringWithFormat:@"昨天 %@:%@",strHour,strMinute];
    }else{
        dateStr = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDay];
    }
    
    return dateStr;
}

- (NSString*)formatWithInteger:(NSInteger)integer
{
    NSString *str = integer < 10?[NSString stringWithFormat:@"0%lu",(long)integer]:[NSString stringWithFormat:@"%lu",(long)integer];
    return str;
}


@end
