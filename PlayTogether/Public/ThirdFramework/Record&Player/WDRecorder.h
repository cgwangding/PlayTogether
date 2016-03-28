//
//  WDRecorder.h
//  RecorderDemo
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RecordSucceed)(NSURL *filePath,NSTimeInterval recordTime);
typedef void(^RecordFailed)(NSError *error);

typedef void(^AudioPowerListener)(float audioPower);

@protocol WDRecorderDelegate;

@interface WDRecorder : NSObject

/**
 *  录音的代理，block或者代理使用一个即可
 */
@property (weak, nonatomic) id<WDRecorderDelegate>delegate;



/**
 *  录音音频的波动
 */
@property (assign, nonatomic, readonly) float audioPower;

/**
 * 录音音频波动变化时的回调
 */
- (void)addAudioPowerListener:(AudioPowerListener)listener;


/**
 *  开始录音
 */
- (void)startRecord;
/**
 *  暂停录音
 */
- (void)pauseRecord;
/**
 *  停止录音
 */
- (void)stopRecord;

/**
 *  取消录音
 */
- (void)cancelRecord;

/**
 *  录音文件保存的地址
 *
 *  @return 返回文件所在的地址
 */
- (NSURL*)savePath;



/**
 *  录音成功
 */
- (void)didRecordSucceed:(RecordSucceed)recordSucceed;
/**
 *  录音失败
 */
- (void)didRecordFailed:(RecordFailed)recordFailed;


- (BOOL)canRecord;

@end


@protocol WDRecorderDelegate <NSObject>

@optional

- (void)recorder:(WDRecorder*)recorder didSuccessfullyWithFilePath:(NSURL*)filePath recordTime:(NSTimeInterval)time;

- (void)recorder:(WDRecorder*)recorder didFailedWithError:(NSError*)error;




@end