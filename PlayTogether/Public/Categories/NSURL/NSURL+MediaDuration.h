//
//  NSURL+MediaDuration.h
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/26.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (MediaDuration)

/**
 *  <#Description#>
 *
 *  @param mediaDuation <#mediaDuation description#>
 */
- (void)timeIntervalForMediaWithCompeletion:(void(^)(NSTimeInterval mediaDuation))mediaDuation;
@end
