//
//  DMStackHistogramViewController.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/4.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackHistogramViewController.h"
#import "DMStackHistogramView.h"
#import "DMStackPopViewController.h"
@interface DMStackHistogramViewController ()<DMStackHistogramViewDataSource,DMStackHistogramViewDelegate,UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) DMStackHistogramView *stackView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *x_values;
@end

@implementation DMStackHistogramViewController

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)x_values{
    if (!_x_values) {
        _x_values = [NSMutableArray array];
    }
    return _x_values;
}

- (DMStackHistogramView *)stackView{
    if (!_stackView) {
        _stackView = [[DMStackHistogramView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
        _stackView.delegate = self;
        _stackView.dataSource = self;
    }
    return _stackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.stackView];
    for (NSInteger j = 0; j < 20; j++) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < 10; i++) {
            if (i == 3) {
                [array addObject:@"0"];
            }else{
                [array addObject:[NSString stringWithFormat:@"%zd", (arc4random() % 30)]];
            }
        }
        [self.dataSource addObject:array];
        [self.x_values addObject:[NSString stringWithFormat:@"%zd",j]];
    }
    NSLog(@"=====%@",self.dataSource);
    self.stackView.y_values = self.dataSource;

}




- (NSArray *)stackView:(DMStackHistogramView *)stackView colorForItem:(NSIndexPath *)indexPath{
    return @[[UIColor redColor],
             [UIColor blueColor],
             [UIColor yellowColor],
             [UIColor orangeColor],
             [UIColor blackColor],
             [UIColor darkGrayColor],
             [UIColor greenColor],
             [UIColor magentaColor],
             [UIColor purpleColor],
             [UIColor brownColor],
             [UIColor redColor],
             [UIColor blueColor],
             [UIColor yellowColor],
             [UIColor orangeColor],
             [UIColor blackColor],
             [UIColor darkGrayColor],
             [UIColor greenColor],
             [UIColor magentaColor],
             [UIColor purpleColor],
             [UIColor brownColor]];
}

- (NSArray *)stackView:(DMStackHistogramView *)stackView xValueForItem:(NSIndexPath *)indexPath{
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"1",@"1",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"1",@"1"];
}

- (void)stackView:(DMStackHistogramView *)stackView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath{
     DMStackPopViewController *levelVC = [DMStackPopViewController shareInstance];
    CollectionViewCell *cell = (CollectionViewCell *)[stackView.stackCollectionView cellForItemAtIndexPath:indexPath];
    CGRect bound =  [stackView convertRect:cell.frame fromView:stackView.stackCollectionView];
    levelVC.modalPresentationStyle = UIModalPresentationPopover;
    levelVC.popoverPresentationController.sourceView = stackView;  //rect参数是以view的左上角为坐标原点（0，0）
    levelVC.popoverPresentationController.sourceRect = bound; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    levelVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny; //箭头方向
    levelVC.popoverPresentationController.delegate = self;
    levelVC.preferredContentSize = CGSizeMake(100, 200);
//    levelVC.popoverPresentationController.passthroughViews = @[stackView.stackCollectionView];
    [self presentViewController:levelVC animated:YES completion:nil];


//    levelVC.delegate = self;
   }
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
