//
//  DMStackPopViewController.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/6.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackPopViewController.h"

@interface DMStackPopViewController ()

@end

@implementation DMStackPopViewController

+ (instancetype)shareInstance{
    static id shareId = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       shareId = [[DMStackPopViewController alloc]init];
    });
    return shareId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
