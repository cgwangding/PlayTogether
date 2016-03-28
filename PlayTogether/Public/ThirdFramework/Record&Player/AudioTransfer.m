//
//  AudioTransfer.m
//  AlarmPolice
//
//  Created by AD-iOS on 15/12/28.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "AudioTransfer.h"

lame_t lame;

@implementation AudioTransfer

- (instancetype)init
{
    if (self = [super init]) {
        [self configTransferProperty];
    }
    return self;
}

- (void)configTransferProperty
{
    lame = lame_init();
    lame_set_num_channels(lame, 1);// 单声道
    lame_set_in_samplerate(lame, 11025.0);// 8K采样率
    lame_set_VBR(lame, vbr_default);
    lame_init_params(lame);
}

- (NSData*)transferWavToMp3:(NSData*)data
{
    short *recordData = (short *)data.bytes;
    long pcmLen = data.length;
    long nsamples = pcmLen / 2;
    unsigned char buffer[pcmLen];
    
    int recvLen = lame_encode_buffer(lame, recordData, recordData, (int)nsamples, buffer, (int)pcmLen);
    NSData *mp3Data = [[NSData alloc]initWithBytes:buffer length:recvLen];
    lame_close(lame);
    return mp3Data;
}


@end
