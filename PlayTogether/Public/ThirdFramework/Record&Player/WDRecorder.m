//
//  WDRecorder.m
//  RecorderDemo
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "WDRecorder.h"
#import <AVFoundation/AVFoundation.h>

#define kRecorderFileName @"recorder.wav"

@interface WDRecorder ()<AVAudioRecorderDelegate>

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSTimeInterval recordTime;

@property (copy, nonatomic) AudioPowerListener listener;

@property (copy, nonatomic) RecordSucceed recordSucceed;

@property (copy, nonatomic) RecordFailed recordFailed;

@property (assign, nonatomic) BOOL isRecordCanceled;

@end

@implementation WDRecorder

- (instancetype)init
{
    if (self = [super init]) {
        [self setAudioSession];
        [self.audioRecorder prepareToRecord];
        self.recordTime = 0;
        [self addNotification];
        
    }
    return self;
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(invalidateTimer) name:UIApplicationWillResignActiveNotification object:nil];

}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - notification

- (void)invalidateTimer
{
    [self.audioRecorder stop];
    [[AVAudioSession sharedInstance]setActive:NO error:nil];
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}



#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (self.isRecordCanceled) {
        NSError *error = [NSError errorWithDomain:@"录音已取消" code:-100 userInfo:nil];
        if ([self.delegate respondsToSelector:@selector(recorder:didFailedWithError:)]) {
            [self.delegate recorder:self didFailedWithError:error];
        }
        if (self.recordFailed) {
            self.recordFailed(error);
        }
        return;
    }
    
    if (flag) {
        if ([self.delegate respondsToSelector:@selector(recorder:didSuccessfullyWithFilePath:recordTime:)]) {
            [self.delegate recorder:self didSuccessfullyWithFilePath:self.audioRecorder.url recordTime:self.recordTime];
        }
        if (self.recordSucceed) {
            self.recordSucceed(self.audioRecorder.url,self.recordTime);
        }
        self.recordTime = 0;
    }else{
        NSLog(@"录音失败");
    }
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error
{
    if (error) {
        if ([self.delegate respondsToSelector:@selector(recorder:didFailedWithError:)]) {
            [self.delegate recorder:self didFailedWithError:error];
        }
        if (self.recordFailed) {
            self.recordFailed(error);
        }
    }
}

#pragma mark  - public method

- (void)startRecord
{
    if ([self canRecord]) {
        if (![self.audioRecorder isRecording]) {
            self.isRecordCanceled = NO;
            [self setAudioSession];
            [self.audioRecorder record];
            [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
            [self.timer setFireDate:[NSDate date]];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未获得授权使用麦克风" message:@"请在\"设置\"->\"隐私\"->\"麦克风\"中打开" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)pauseRecord
{
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        [self fireTimerDistantFuture];
    }
}

- (void)stopRecord
{
    
    [self.audioRecorder stop];
    [[AVAudioSession sharedInstance]setActive:NO error:nil];
    [self fireTimerDistantFuture];
    self.audioPower = 0.0;
    
}

- (void)cancelRecord
{
    self.isRecordCanceled = YES;
    [self stopRecord];
    [self.audioRecorder deleteRecording];
    
}

- (void)addAudioPowerListener:(AudioPowerListener)listener
{
    self.listener      = listener;
}

- (void)didRecordFailed:(RecordFailed)recordFailed
{
    self.recordFailed  = recordFailed;
}

- (void)didRecordSucceed:(RecordSucceed)recordSucceed
{
    self.recordSucceed = recordSucceed;
}

- (void)fireTimerDistantFuture
{
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    
    return bCanRecord;
}

#pragma mark - private method

- (NSURL*)savePath
{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecorderFileName];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

- (void)setAudioSession
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(11025.0) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    
     [dicM setObject:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    //....其他设置等
    return dicM;
}

#pragma mark - timer action
/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float   level;                // The linear 0.0 .. 1.0 value we need.
    
    float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
    
    float   decibels = [self.audioRecorder averagePowerForChannel:0];
    
    if (decibels < minDecibels){
        level = 0.0f;
    }else if (decibels >= 0.0f){
        level = 1.0f;
    }else{
        float   root            = 2.0f;
        
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        
        float   amp             = powf(10.0f, 0.05f * decibels);
        
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
    }
    self.audioPower = level;
    self.recordTime += 0.1;
    if(self.listener){
        self.listener(level);
    }
}

#pragma mark - setter

- (void)setAudioPower:(float)audioPower
{
    _audioPower = audioPower;
}

#pragma mark - getter 

- (AVAudioRecorder *)audioRecorder
{
    if (_audioRecorder == nil) {
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:[self savePath] settings:[self getAudioSetting] error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;
        if (error) {
            NSLog(@"录音机创建错误%@",error.localizedDescription);
            return nil;
        }
        
    }
    return _audioRecorder;
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - dealloc

- (void)dealloc
{
    [self removeNotification];
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
