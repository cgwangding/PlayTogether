//
//  NSURL+MediaDuration.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/26.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "NSURL+MediaDuration.h"
#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>

@implementation NSURL (MediaDuration)

- (void)timeIntervalForMediaWithCompeletion:(void(^)(NSTimeInterval mediaDuation))mediaDuation
{
    //AVURLAssetPreferPreciseDurationAndTimingKey该值为yes时，duration需要返回一个精确值，计算量会比较大，耗时比较长，为NO时返回的是一个估算值
    AVURLAsset * audioAsset = [AVURLAsset URLAssetWithURL:self options:@{AVURLAssetPreferPreciseDurationAndTimingKey:@YES}];
    
    [audioAsset loadValuesAsynchronouslyForKeys:@[@"duration"] completionHandler:^{
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        DDLog(@"duaration: %f",audioDurationSeconds);
        if (mediaDuation) {
            dispatch_async(dispatch_get_main_queue(), ^{
                mediaDuation(audioDurationSeconds);
            });
        }
    }];
}

@end
