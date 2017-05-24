//
//  DMStackHistogramYCoordinateView.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/5.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackHistogramYCoordinateView.h"

@interface DMStackHistogramYCoordinateView ()
@property (nonatomic, strong) NSMutableArray <UILabel *>*yAxisLabels;
@end

@implementation DMStackHistogramYCoordinateView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setYAxisValues:(NSArray<NSString *> *)yAxisValues{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat height = self.frame.size.height - 20;
    CGFloat spaceHeight = (height - 20) / 4;

    for (NSInteger i = 0; i < yAxisValues.count; i++) {
        UILabel *textLab = [[UILabel alloc] init];
        textLab.textAlignment = NSTextAlignmentRight;
        textLab.textColor = [UIColor lightGrayColor];
        textLab.numberOfLines = 2;
        textLab.font = [UIFont systemFontOfSize:9];
        textLab.bounds = CGRectMake(0, 0, self.frame.size.width - 15, 40);
        textLab.center = CGPointMake(self.frame.size.width * 0.5, height - spaceHeight * i);
        textLab.text = [yAxisValues objectAtIndex:i];
        [self addSubview:textLab];
    }

}



@end
