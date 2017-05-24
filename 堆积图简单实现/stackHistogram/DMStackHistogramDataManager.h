//
//  DMStackHistogramDataManager.h
//  CollectionLayout
//
//  Created by dqb on 2017/4/5.
//  Copyright © 2017年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DMStackHistogramDataManager : NSObject
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) CGFloat stackViewContentHeight;
/**
 *多个堆积图 不要用此方法
 */
+ (instancetype)shareInstance;
- (NSArray *)yAxisValues;
- (NSArray *)stackHistogramAllItemsHeight;
@end
