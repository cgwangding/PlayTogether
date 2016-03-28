//
//  WDAudioPlayer.m
//  RecorderDemo
//
//  Created by AD-iOS on 15/12/2.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "WDAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface WDAudioPlayer ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation WDAudioPlayer

- (instancetype)initWithContentURL:(NSURL*)url
{
    if (self = [super init]) {
        [self setAudioSession];
        NSError *error = nil;
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData*)data
{
    if (self = [super init]) {
        [self setAudioSession];
        NSError *error = nil;
        self.audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:&error];
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }
    return self;
}

- (void)setAudioSession
{
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance]setActive:YES error:nil];
}
#pragma mark - 
/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{

}

#if TARGET_OS_IPHONE



- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags NS_DEPRECATED_IOS(4_0, 6_0)
{

}

/* audioPlayerEndInterruption: is called when the preferred method, audioPlayerEndInterruption:withFlags:, is not implemented. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 6_0)
{

}

#endif // TARGET_OS_IPHONE


#pragma mark - audio play control
- (void)audioPlay
{
    if ([self.audioPlayer isPlaying] == NO) {
        [self.audioPlayer play];
//        sleep(self.audioPlayer.duration);
    }
}

- (void)audioPause
{
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
    }
}

- (void)audioStop
{
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
}

@end
