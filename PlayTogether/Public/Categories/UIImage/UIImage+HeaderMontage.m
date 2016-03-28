


//
//  UIImage+HeaderMontage.m
//  CompetitionApply
//
//  Created by AD-iOS on 15/8/26.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "UIImage+HeaderMontage.h"

#define ImageWidth 100.0
#define ImageHieght 100.0

@implementation UIImage (HeaderMontage)

+ (UIImage*)makeHeaderWithArray:(NSArray*)array
{
    UIGraphicsBeginImageContext(CGSizeMake(ImageWidth, ImageHieght));
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (array.count) {
        case 0:
        {
            CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, ImageWidth, ImageHieght));
        }
            break;
        case 1:
        {
            UIImage *image = (UIImage*)array.lastObject;
            [image drawInRect:CGRectMake(ImageWidth / 4.0, ImageHieght / 4.0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            
        }
            break;
        case 2:
        {
            UIImage *image1 = (UIImage*)array[0];
            UIImage *image2 = (UIImage*)array[1];
            [image1 drawInRect:CGRectMake(0, ImageHieght / 4.0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            [image2 drawInRect:CGRectMake(ImageWidth / 2.0, ImageHieght / 4.0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
        }
            break;
        case 3:
        {
            UIImage *image1 = (UIImage*)array[0];
            UIImage *image2 = (UIImage*)array[1];
            UIImage *image3 = (UIImage*)array[2];
            [image2 drawInRect:CGRectMake(0, ImageHieght / 2.0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            [image3 drawInRect:CGRectMake(ImageWidth / 2.0, ImageHieght / 2.0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            [image1 drawInRect:CGRectMake(ImageWidth / 4.0, 0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
        }
            break;
        default:
        {
            UIImage *image1 = (UIImage*)array[0];
            UIImage *image2 = (UIImage*)array[1];
            UIImage *image3 = (UIImage*)array[2];
            UIImage *image4 = (UIImage*)array[3];
            [image1 drawInRect:CGRectMake(0, 0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            [image2 drawInRect:CGRectMake(ImageWidth / 2.0, 0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            [image3 drawInRect:CGRectMake(0, ImageHieght / 2.0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            [image4 drawInRect:CGRectMake(ImageWidth / 2.0, ImageHieght / 2.0, ImageWidth / 2.0, ImageHieght / 2.0) blendMode:kCGBlendModeNormal alpha:1.0];
            
        }
            break;
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

+ (void)makeHeaderWithURLArray:(NSArray*)array compeletionHander:(void(^)(UIImage *image))compeleting failed:(void(^)(NSError*error))failed
{
    NSMutableArray *imageArr = [NSMutableArray arrayWithArray:array];
    NSOperationQueue *opQueue = [[NSOperationQueue alloc]init];
    opQueue.maxConcurrentOperationCount = 1;
    
    for (NSString *urlStr in array) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlStr]];
            if (data) {
                int reIndex = 0;
                for (int i = 0; i < imageArr.count; i++) {
                    if ([imageArr[i] isKindOfClass:[NSString class]]) {
                        reIndex = i;
                        break;
                    }
                }
                [imageArr replaceObjectAtIndex:reIndex withObject:[UIImage imageWithData:data]];
            }
        }];
        [opQueue addOperation:op];
    }
    
    [opQueue waitUntilAllOperationsAreFinished];
    BOOL isAllImage = YES;
    for (id obj in imageArr) {
        if ([obj isKindOfClass:[NSString class]]) {
            isAllImage = NO;
            break;
        }
    }
    if (isAllImage && imageArr.count > 0) {
        UIImage *image = [UIImage makeHeaderWithArray:imageArr];
        compeleting(image);
    }
    NSError *error = [NSError errorWithDomain:@"图片加载失败" code:404 userInfo:nil];
    failed(error);

}

@end
