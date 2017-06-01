//
//  ViewController.m
//  CxmChartView_demo
//
//  Created by 陈小明 on 2017/6/1.
//  Copyright © 2017年 陈小明. All rights reserved.
//

#import "ViewController.h"
#import "SmoothChartView.h"

@interface ViewController ()
{
  
    SmoothChartView *_smoothView;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self makeChartView];
    
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesDown)];
    
    [self.view addGestureRecognizer:tapGes];
    
 
}
#pragma mark - 作图表
-(void)makeChartView{
    
    _smoothView = [[SmoothChartView alloc] initWithFrame:CGRectMake(30, 227/2, 616/2,392/2)];
    _smoothView.backgroundColor = [UIColor whiteColor];
    //X轴刻度
    _smoothView.arrX = @[@"9时",@"13时",@"18时"];
    // Y轴刻度
    _smoothView.arrY = @[@"0",@"10",@"20",@"30",@"40",@"50"];
    
    [self.view addSubview:_smoothView];
    
    [_smoothView refreshChartAnmition];
    NSArray *pathX = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSArray *pathY = @[@"19",@"27",@"8",@"38",@"30",@"45",@"40",@"48",@"22",@"7"];
    
    [_smoothView drawSmoothViewWithArrayX:pathX andArrayY:pathY andScaleX:12.0];

    
}
-(void)tapGesDown{

    [_smoothView refreshChartAnmition];
    
    NSArray *pathX = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSArray *pathY = @[@"19",@"27",@"8",@"38",@"30",@"45",@"40",@"48",@"22",@"7"];
    
    [_smoothView drawSmoothViewWithArrayX:pathX andArrayY:pathY andScaleX:12.0];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
