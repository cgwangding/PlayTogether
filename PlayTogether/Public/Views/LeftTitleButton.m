

//
//  LeftTitleButton.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/26.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "LeftTitleButton.h"

@implementation LeftTitleButton

- (void)setShouldUseLeftTitle:(BOOL)shouldUseLeftTitle
{
    _shouldUseLeftTitle = shouldUseLeftTitle;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.shouldUseLeftTitle) {
        self.titleLabel.frame = CGRectMake(0, 0, self.width - 10, self.height);
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
}

@end
