//
//  SmoothChartView.m
//  AseanData
//
//  Created by 陈小明 on 2017/4/24.
//  Copyright © 2017年 wanshenglong. All rights reserved.
//平滑的曲线

#import "SmoothChartView.h"
#import "UIBezierPath+curved.h"

@interface SmoothChartView ()
{
    CAShapeLayer *anmitionLayer;
    CAGradientLayer *gradientLayer;
    NSMutableArray *_pointArr;
    
    //X轴
    CAShapeLayer *layerX;
    
    //纵坐标轴
    CAShapeLayer *layerY;
    
    CAShapeLayer *_bottomLayer;
    
}
@end
#define  VIEW_WIDTH  self.frame.size.width
#define  VIEW_HEIGHT self.frame.size.height

#define  LABLE_WIDTH  280
#define  LABLE_HEIGHT 149

@implementation SmoothChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        // X轴
        [self makeChartXView];
        // Y轴
        [self makeChartYView];
        // 承载曲线图的View
        [self makeBottomlayer];
        
    }
    return self;
}
-(void)initData{

    _pointArr = [[NSMutableArray alloc] initWithCapacity:0];
}
-(void)makeChartXView{

    //X轴
    layerX = [CAShapeLayer layer];
    layerX.frame = CGRectMake(25,LABLE_HEIGHT + 25, LABLE_WIDTH, 1);
    layerX.backgroundColor = [UIColor colorFromHexCode:@"d8d8d8"].CGColor;
    [self.layer addSublayer:layerX];
    
}
-(void)makeChartYView{

    //左侧纵坐标轴
    layerY = [CAShapeLayer layer];
    layerY.frame = CGRectMake(25,25, 1, LABLE_HEIGHT);
    layerY.backgroundColor = [[UIColor colorFromHexCode:@"d8d8d8"] CGColor];
    [self.layer addSublayer:layerY];
    
    float height= 30;
    // 纵坐标上的横线
    for (int i=0; i<5; i++) {
        if (i!=5) {
            CAShapeLayer *layer5 = [CAShapeLayer layer];
            layer5.frame = CGRectMake(0, i*height,LABLE_WIDTH, 0.5f);
            layer5.backgroundColor = [[UIColor colorFromHexCode:@"d8d8d8"] CGColor];
            [layerY addSublayer:layer5];
        }
    }
    
    // 右侧侧纵轴线
    CAShapeLayer *layerLeft = [CAShapeLayer layer];
    layerLeft.frame = CGRectMake(VIEW_WIDTH-2,25, 0.5f, LABLE_HEIGHT);
    layerLeft.backgroundColor = [[UIColor colorFromHexCode:@"d8d8d8"] CGColor];
    [self.layer addSublayer:layerLeft];

}

-(void)makeBottomlayer{

    _bottomLayer = [CAShapeLayer layer];
    _bottomLayer.backgroundColor = [UIColor clearColor].CGColor;
    _bottomLayer.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.layer addSublayer:_bottomLayer];
}
-(void)setArrX:(NSArray *)arrX{
    _arrX = arrX;
    
    [layerX removeFromSuperlayer];
    [self makeChartXView];
    
    CGFloat width = (VIEW_WIDTH-30)/3;
    
    for (NSInteger i=0; i<arrX.count; i++) {
        
        UILabel *label = (UILabel*)[self viewWithTag:5000+i];
        [label removeFromSuperview];
    }
    //横坐标上的数字
    for (int i=0; i<arrX.count; i++) {
        
        UILabel *layer3 = [UILabel new];
        layer3.frame = CGRectMake((VIEW_WIDTH - LABLE_WIDTH)+i*width+25, VIEW_HEIGHT - 20, width, 20);
        layer3.text = [NSString stringWithFormat:@"%@",_arrX[i]];
        layer3.font = [UIFont systemFontOfSize:12];
        layer3.textAlignment = NSTextAlignmentLeft;
        layer3.tag = 5000+i;
        layer3.textColor = [UIColor colorFromHexCode:@"999999"];
        [self addSubview:layer3];

        
//        CATextLayer *layer3 = [CATextLayer layer];
//        layer3.frame = CGRectMake((VIEW_WIDTH - LABLE_WIDTH)+i*width, 5, width, 20);
//        layer3.string = [NSString stringWithFormat:@"%@",_arrX[i]];
//        layer3.fontSize = 12;
//        layer3.foregroundColor = [[UIColor colorFromHexCode:@"999999"] CGColor];
//        [layerX addSublayer:layer3];
    }

}
-(void)setArrY:(NSArray *)arrY{
    _arrY = arrY;
    
    [layerY removeFromSuperlayer];
    [self makeChartYView];
    
    float height= 30;

    for (NSInteger i=0; i<6; i++) {
        
        UILabel *label = (UILabel*)[self viewWithTag:4000+i];
        [label removeFromSuperview];
    }
    
    //纵坐标上的数字
    for (int i=0; i<6; i++) {
        
        UILabel *layer6 = [UILabel new];
        layer6.frame = CGRectMake(-5,LABLE_HEIGHT-(i*height)+15, 25, 20);
        layer6.text = [NSString stringWithFormat:@"%@",_arrY[i]];
        layer6.font = [UIFont systemFontOfSize:12];
        layer6.textAlignment = NSTextAlignmentRight;
        layer6.tag = 4000+i;
        layer6.textColor = [UIColor colorFromHexCode:@"999999"];
        [self addSubview:layer6];

//        CATextLayer *layer6 = [CATextLayer layer];
//        layer6.frame = CGRectMake(-30,LABLE_HEIGHT-(i*height)-6, 25, 20);
//        layer6.string = [NSString stringWithFormat:@"%@",_arrY[i]];
//        layer6.fontSize = 12;
//        layer6.alignmentMode = kCAAlignmentRight;
//        layer6.foregroundColor = [[UIColor colorFromHexCode:@"999999"] CGColor];
//        [layerY addSublayer:layer6];
    
    }
}
//画图
-(void)drawSmoothViewWithArrayX:(NSArray*)pathX andArrayY:(NSArray*)pathY andScaleX:(float)X{

    [_bottomLayer removeFromSuperlayer];
    [self makeBottomlayer];
    [_pointArr removeAllObjects];
    
    // 创建layer并设置属性
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  3.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor colorFromHexCode:@"00c1ed"].CGColor;
    [_bottomLayer addSublayer:layer];
    
    CGPoint point;
    // 创建贝塞尔路径~
    UIBezierPath *path = [UIBezierPath bezierPath];

    //X轴和Y轴的倍率
    CGFloat BLX = (LABLE_WIDTH-15)/X;
    CGFloat BLY = LABLE_HEIGHT/[[_arrY lastObject] floatValue];
    
    for (int i= 0; i< pathY.count; i++) {
        
        CGFloat X = [pathX[i] floatValue]*BLX +(VIEW_WIDTH - LABLE_WIDTH) +10;
        CGFloat Y = LABLE_HEIGHT - [pathY[i] floatValue]*BLY +(VIEW_HEIGHT - LABLE_HEIGHT)/2;//(VIEW_HEIGHT - LABLE_HEIGHT)/2是指图表在背景大图的的height
        
        //NSLog(@"space==%lf",VIEW_HEIGHT - LABLE_HEIGHT);
        point = CGPointMake(X, Y);

        [_pointArr addObject:[NSValue valueWithCGPoint:point]];
        
        if (i==0) {
            [path moveToPoint:point];//起点
        }
        
        [path addLineToPoint:point];
    }
    
    path = [path smoothedPathWithGranularity:20];
    // 关联layer和贝塞尔路径~
    layer.path = path.CGPath;
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(3.0);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    
    // 设置layer的animation
    [layer addAnimation:animation forKey:nil];
    
    layer.strokeEnd = 1;
    anmitionLayer = layer;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self drawGradient];
        
    });

}

#pragma mark 渐变阴影
- (void)drawGradient {
    
    [gradientLayer removeAllAnimations];
    [gradientLayer removeFromSuperlayer];
    
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0,0, LABLE_WIDTH, VIEW_HEIGHT -23);
    gradientLayer.colors =@[(__bridge id)[UIColor colorWithRed:46/255.0 green:200/255.0 blue:237/255.0 alpha:0.5].CGColor,(__bridge id)[UIColor colorWithRed:240/255.0 green:252/255.0 blue:254/255.0 alpha:0.4].CGColor];
    
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    
   // NSLog(@"Y====%lf",[[_pointArr firstObject] CGPointValue].y);

    CGPoint firstPoint = CGPointMake([[_pointArr firstObject] CGPointValue].x,LABLE_HEIGHT+25) ;

    CGPoint lastPoint =  [[_pointArr lastObject] CGPointValue];
    
   // NSLog(@"firstPointX===%lf firstpointY==%lf",firstPoint.x,firstPoint.y);
    [gradientPath moveToPoint:firstPoint];
    
    for (int i = 0; i < _pointArr.count; i ++) {
        [gradientPath addLineToPoint:[_pointArr[i] CGPointValue]];
    }
    // 圆滑曲线
    gradientPath = [gradientPath smoothedPathWithGranularity:20];
    
    CGPoint endPoint = lastPoint;
    endPoint = CGPointMake(endPoint.x , VIEW_WIDTH +23);
    [gradientPath addLineToPoint:endPoint];
    
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = gradientPath.CGPath;
    gradientLayer.mask = arc;
    [anmitionLayer addSublayer:gradientLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(0.3);
    animation.toValue = @(1);
    animation.autoreverses = NO;
    animation.duration = 2.0;
    [gradientLayer addAnimation:animation forKey:nil];
    
}
-(void)refreshChartAnmition{
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(3.0);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    
    // 设置layer的animation
    [anmitionLayer addAnimation:animation forKey:nil];
    
    anmitionLayer.strokeEnd = 1;
    
    [gradientLayer removeAllAnimations];
    [gradientLayer removeFromSuperlayer];
    
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [gradientLayer removeAllAnimations];
         [gradientLayer removeFromSuperlayer];
         
        [self drawGradient];
        
    });
}
@end
