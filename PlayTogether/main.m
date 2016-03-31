//
//  main.m
//  PlayTogether
//
//  Created by AD-iOS on 16/3/28.
//  Copyright © 2016年 DW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //听云
        [NBSAppAgent startWithAppID:@"51b1126d0f51465183807196eba61a1e"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
