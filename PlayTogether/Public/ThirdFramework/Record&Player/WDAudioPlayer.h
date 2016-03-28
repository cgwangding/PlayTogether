//
//  WDAudioPlayer.h
//  RecorderDemo
//
//  Created by AD-iOS on 15/12/2.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDAudioPlayer : NSObject

- (instancetype)initWithContentURL:(NSURL*)url;
- (instancetype)initWithData:(NSData*)data;

- (void)audioPlay;
- (void)audioPause;
- (void)audioStop;
@end
