//
//  DMStackHistogramCollectionView.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/4.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackHistogramCollectionView.h"

@interface DMStackHistogramCollectionView ()


@end

@implementation DMStackHistogramCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGFloat height = self.frame.size.height - 20;
    CGFloat spaceHeight = (height - 20) / 4;
    //1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.设置当前上下问路径
    //设置起始点
    for (NSInteger i = 0; i < 5; i++) {
        CGContextMoveToPoint(context, 0, height - i*spaceHeight);
        CGContextAddLineToPoint(context, self.frame.size.width, height - i*spaceHeight);
    }
    CGContextClosePath(context);
    [[UIColor lightGrayColor]setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
