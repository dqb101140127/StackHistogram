//
//  DMStackHistogramDataManager.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/5.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackHistogramDataManager.h"

@interface DMStackHistogramDataManager ()
{
    NSArray *_yAxisValues;
    NSArray *_itemsHeight;
}
@end

@implementation DMStackHistogramDataManager

+ (instancetype)shareInstance{
    static id shareId = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareId = [[[self class] alloc] init];
    });
    return shareId;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    NSArray *maxValues = [self calculateSumForEachSection:dataSource];
    NSInteger minInteger = [self getminInteger:maxValues];
    NSArray *yAxisValues = [self processDataForYAxis:minInteger];
    _yAxisValues = yAxisValues;
    
    NSMutableArray *itemsHeight = [NSMutableArray array];
    for (NSInteger i = 0; i < dataSource.count; i++) {
        NSArray *sectionItemsHeight = [self _processYAxisHeght:i];
        [itemsHeight addObject:sectionItemsHeight];
    }
    _itemsHeight = itemsHeight;
}


- (NSArray *)calculateSumForEachSection:(NSArray *)dataSource{
    NSMutableArray *maxValues = [NSMutableArray array];
    for (NSArray *values in dataSource) {
        if (values.count) {
            NSString *maxValue = [values valueForKeyPath:@"@sum.floatValue"];
            [maxValues addObject:maxValue];
        }else{
            [maxValues addObject:@"0"];
        }
    }
    return maxValues;
}



- (NSArray *)processDataForYAxis:(NSInteger)minInteger{
    NSMutableArray *yAxisValues = [NSMutableArray array];
    NSInteger a = minInteger / 4;
    for (NSInteger i = 0; i < 5; i++) {
        NSInteger b = a * i;
        [yAxisValues addObject:[NSString stringWithFormat:@"%zd",b]];
    }
    return yAxisValues;
}

- (NSInteger)getminInteger:(NSArray *)values{
    NSInteger value =  [[values valueForKeyPath:@"@max.floatValue"] floatValue];
    NSInteger i = 0;
    NSInteger maxBit = 0;
    do {
        i++;
        if (value>0 && value < 10) {
            maxBit = value;
        }
        value = value * 0.1;
    } while (value > 0);
    
    return pow(10, (i - 1)) *(maxBit + 1);
}

- (NSArray *)_processYAxisHeght:(NSInteger)section{
    CGFloat totalHeight = _stackViewContentHeight;
    NSArray *maxValues = [self calculateSumForEachSection:self.dataSource];
    NSInteger minInteger = [self getminInteger:maxValues];
    
    
    NSMutableArray *heights = [NSMutableArray array];
    NSArray *values = [self.dataSource objectAtIndex:section];
    CGFloat valueSum = [[values valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat eachTotalHeight = (totalHeight * valueSum) / minInteger;
    for (NSString *value in values) {
        if (valueSum > 0.0f) {
            CGFloat height = (eachTotalHeight * [value floatValue] )/ valueSum;
            [heights addObject:@(height)];
        }else{
            [heights addObject:@(0)];
        }
    }
    return heights;
}


- (NSArray *)yAxisValues{
    return _yAxisValues;
}

- (NSArray *)stackHistogramAllItemsHeight{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"---datamanager--%@",_itemsHeight);
//    });
    return _itemsHeight;
}


@end
