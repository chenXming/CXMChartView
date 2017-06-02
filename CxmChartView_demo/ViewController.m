//
//  ViewController.m
//  CxmChartView_demo
//
//  Created by 陈小明 on 2017/6/1.
//  Copyright © 2017年 陈小明. All rights reserved.
//

#import "ViewController.h"
#import "SmoothChartView.h"
#import "BrokenChartView.h"

@interface ViewController ()
{
  
    SmoothChartView *_smoothView;
 
    BrokenChartView *_brokenView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 平滑曲线带阴影
    [self makeSmoothChartView];
    
    //双基准坐标 折线图
    [self makeBrokenChartView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesDown)];
    
    [self.view addGestureRecognizer:tapGes];
    
 
}
#pragma mark - 作图表
-(void)makeSmoothChartView{
    
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
-(void)makeBrokenChartView{


    _brokenView = [[BrokenChartView alloc] initWithFrame:CGRectMake(30, 350,680/2,392/2)];
    _brokenView.backgroundColor = [UIColor whiteColor];
    _brokenView.arrX =@[@"9时",@"13时",@"18时"];
    _brokenView.arrLeftY =@[@"0",@"10",@"20",@"30",@"40",@"50"];
    _brokenView.arrRightY = @[@"0",@"100",@"200",@"300",@"400",@"500"];
    
    [self.view addSubview:_brokenView];
    
    NSArray *pathX = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSArray *arrLeft= @[@"5",@"10",@"15",@"26",@"29",@"22",@"33",@"38",@"45",@"49"];
    NSArray *arrRight= @[@"50",@"100",@"120",@"230",@"129",@"202",@"300",@"308",@"450",@"480"];

    [_brokenView drawLeftChartViewWithArrayX:pathX ArrayY:arrLeft andScaleX:12];
    [_brokenView drawRightChartViewWithArrayX:pathX ArrayY:arrRight andScaleX:12];
    
}
-(void)tapGesDown{

    [_smoothView refreshChartAnmition];
    
    [_brokenView refreshChartAnmition];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
