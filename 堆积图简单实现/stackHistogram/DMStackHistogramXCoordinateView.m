//
//  DMStackHistogramXCoordinateView.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/4.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackHistogramXCoordinateView.h"
#import <Masonry.h>


@implementation DMStackHistogramXCoordinateView

- (void)prepareForReuse{
    [super prepareForReuse];
    _contentLab.text = @"";
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        __weak __typeof(&*self)weakSelf = self;
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = [UIColor lightGrayColor];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}


@end
