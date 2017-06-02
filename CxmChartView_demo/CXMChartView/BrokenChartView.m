//
//  BrokenChartView.m
//  AseanData
//
//  Created by 陈小明 on 2017/4/25.
//  Copyright © 2017年 wanshenglong. All rights reserved.
//

#import "BrokenChartView.h"
#import "UIColor+Extra.h"


@interface BrokenChartView ()
{
    CAShapeLayer *anmitionLayerLeft;

    CAShapeLayer *anmitionLayerRight;

   // NSMutableArray *_pointArr;
    
    //X轴
    CAShapeLayer *layerX;
    //左侧纵坐标轴
    CAShapeLayer *layerLeftY;
    // 右侧纵轴线
    CAShapeLayer *layerRight;
    
    CAShapeLayer *_bottomLeftLayer;
    CAShapeLayer *_bottomRightLayer;
}

@end
#define  VIEW_WIDTH  self.frame.size.width //底图的宽度
#define  VIEW_HEIGHT self.frame.size.height//底图的高度

#define  LABLE_WIDTH  280 //表的宽度
#define  LABLE_HEIGHT 150 //表的高度

@implementation BrokenChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        
        [self makeChartXView];
        
        [self makeChartLeftYView];
        
        [self makeChartRightYView];
        
        // 承载左侧曲线图的View
        [self makeLeftBottomlayer];
        // 承载右侧曲线图的View
        [self makeRightBottomlayer];
        
    }
    return self;
}
-(void)initData{
    
   // _pointArr = [[NSMutableArray alloc] initWithCapacity:0];
}
-(void)makeChartXView{

    //X轴
    layerX = [CAShapeLayer layer];
    layerX.frame = CGRectMake(25,LABLE_HEIGHT + 25, LABLE_WIDTH, 1);
    layerX.backgroundColor = [UIColor colorFromHexCode:@"d8d8d8"].CGColor;
    [self.layer addSublayer:layerX];

}
-(void)makeChartLeftYView{

    //左侧纵坐标轴
    layerLeftY = [CAShapeLayer layer];
    layerLeftY.frame = CGRectMake(25,25, 1, LABLE_HEIGHT);
    layerLeftY.backgroundColor = [[UIColor colorFromHexCode:@"d8d8d8"] CGColor];
    [self.layer addSublayer:layerLeftY];

    float height= 30;
    
    // 纵坐标上的横线
    for (int i=0; i<5; i++) {
        if (i!=5) {
            CAShapeLayer *layer5 = [CAShapeLayer layer];
            layer5.frame = CGRectMake(0, i*height,LABLE_WIDTH, 0.5f);
            layer5.backgroundColor = [[UIColor colorFromHexCode:@"d8d8d8"] CGColor];
            [layerLeftY addSublayer:layer5];
        }
    }
}
-(void)makeChartRightYView{

    // 右侧纵轴线
    layerRight = [CAShapeLayer layer];
    layerRight.frame = CGRectMake(LABLE_WIDTH+25,25, 0.5f, LABLE_HEIGHT);
    layerRight.backgroundColor = [[UIColor colorFromHexCode:@"d8d8d8"] CGColor];
    [self.layer addSublayer:layerRight];

}
-(void)makeLeftBottomlayer{
    
    _bottomLeftLayer = [CAShapeLayer layer];
    _bottomLeftLayer.backgroundColor = [UIColor clearColor].CGColor;
    _bottomLeftLayer.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.layer addSublayer:_bottomLeftLayer];
    
}
-(void)makeRightBottomlayer{

    _bottomRightLayer = [CAShapeLayer layer];
    _bottomRightLayer.backgroundColor = [UIColor clearColor].CGColor;
    _bottomRightLayer.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.layer addSublayer:_bottomRightLayer];

}
-(void)setArrX:(NSArray *)arrX{
    _arrX = arrX;
    
    [layerX removeAllAnimations];
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
        layer3.frame = CGRectMake((VIEW_WIDTH - LABLE_WIDTH)+i*width-6, VIEW_HEIGHT - 20, width, 20);
        layer3.text = [NSString stringWithFormat:@"%@",_arrX[i]];
        layer3.font = [UIFont systemFontOfSize:12];
        layer3.textAlignment = NSTextAlignmentLeft;
        layer3.tag = 5000+i;
        layer3.textColor = [UIColor colorFromHexCode:@"999999"];
        [self addSubview:layer3];
        
//        CATextLayer *layer3 = [CATextLayer layer];
//        layer3.frame = CGRectMake((VIEW_WIDTH - LABLE_WIDTH)/2+i*width, 5, width, 20);
//        layer3.string = [NSString stringWithFormat:@"%@",_arrX[i]];
//        layer3.fontSize = 12;
//        layer3.foregroundColor = [[UIColor colorFromHexCode:@"999999"] CGColor];
//        [layerX addSublayer:layer3];
    }

}
-(void)setArrLeftY:(NSArray *)arrLeftY{
    _arrLeftY =arrLeftY;
    
    [layerLeftY removeAllAnimations];
    [layerLeftY removeFromSuperlayer];
    [self makeChartLeftYView];
    
    float height= 30;

    for (NSInteger i=0; i<_arrLeftY.count; i++) {
        
        UILabel *label = (UILabel*)[self viewWithTag:4000+i];
        [label removeFromSuperview];
    }
    
    //纵坐标上的数字
    for (int i=0; i<_arrLeftY.count; i++) {
        
        UILabel *layer6 = [UILabel new];
        layer6.frame = CGRectMake(-5,LABLE_HEIGHT-(i*height)+15, 25, 20);
        layer6.text = [NSString stringWithFormat:@"%@",_arrLeftY[i]];
        layer6.font = [UIFont systemFontOfSize:12];
        layer6.textAlignment = NSTextAlignmentRight;
        layer6.tag = 4000+i;
        layer6.textColor = [UIColor colorFromHexCode:@"999999"];
        [self addSubview:layer6];

        
//        CATextLayer *layer6 = [CATextLayer layer];
//        layer6.frame = CGRectMake(-30,LABLE_HEIGHT-(i*height)-6, 25, 20);
//        layer6.string = [NSString stringWithFormat:@"%@",_arrLeftY[i]];
//        layer6.fontSize = 12;
//        layer6.alignmentMode = kCAAlignmentRight;
//        layer6.foregroundColor = [[UIColor colorFromHexCode:@"999999"] CGColor];
//        [layerLeftY addSublayer:layer6];
        
    }

}
-(void)setArrRightY:(NSArray *)arrRightY{
    _arrRightY = arrRightY;
    float height= 30;
    
    [layerRight removeAllAnimations];
    [layerRight removeFromSuperlayer];
    [self makeChartRightYView];
    
    for (NSInteger i=0; i<_arrRightY.count; i++) {
        
        UILabel *label = (UILabel*)[self viewWithTag:6000+i];
        [label removeFromSuperview];
    }
    //右侧侧纵坐标上的数字
    for (int i=0; i<_arrRightY.count; i++) {
        
        UILabel *layer6 = [UILabel new];
        layer6.frame = CGRectMake(VIEW_WIDTH -30,LABLE_HEIGHT-(i*height)+15, 25, 20);
        layer6.text = [NSString stringWithFormat:@"%@",_arrRightY[i]];
        layer6.font = [UIFont systemFontOfSize:12];
        layer6.textAlignment = NSTextAlignmentLeft;
        layer6.tag = 6000+i;
        layer6.textColor = [UIColor colorFromHexCode:@"999999"];
        [self addSubview:layer6];
        
//        CATextLayer *layer6 = [CATextLayer layer];
//        layer6.frame = CGRectMake(5,LABLE_HEIGHT-(i*height)-6, 25, 20);
//        layer6.string = [NSString stringWithFormat:@"%@",_arrRightY[i]];
//        layer6.fontSize = 12;
//        layer6.alignmentMode = kCAAlignmentLeft;
//        layer6.foregroundColor = [[UIColor colorFromHexCode:@"999999"] CGColor];
//        [layerRight addSublayer:layer6];
    }

}
#pragma mark - 作图 （左侧纵坐标刻度为基准）
-(void)drawLeftChartViewWithArrayX:(NSArray *)pathX ArrayY:(NSArray *)pathY andScaleX:(float)X{
    
    [_bottomLeftLayer removeAllAnimations];
    [_bottomLeftLayer removeFromSuperlayer];
    [self makeLeftBottomlayer];
    
    
    // 创建layer并设置属性
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  2.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor colorFromHexCode:@"00c1ed"].CGColor;
    [_bottomLeftLayer addSublayer:layer];
    
    CGPoint point;
    // 创建贝塞尔路径~
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // X轴和Y轴的倍率
    CGFloat BLX = (LABLE_WIDTH-15)/X;
    CGFloat BLY = LABLE_HEIGHT/[[_arrLeftY lastObject] floatValue];
    
    for (int i= 0; i< pathY.count; i++) {
        
        CGFloat X = [pathX[i] floatValue]*BLX +(VIEW_WIDTH - LABLE_WIDTH)/2 +10;
        CGFloat Y = LABLE_HEIGHT - [pathY[i] floatValue]*BLY +(VIEW_HEIGHT - LABLE_HEIGHT)/2;//(VIEW_HEIGHT - LABLE_HEIGHT)/2是指图表在背景大图的的height
        
        //NSLog(@"space==%lf",VIEW_HEIGHT - LABLE_HEIGHT);
        point = CGPointMake(X, Y);
        
       // [_pointArr addObject:[NSValue valueWithCGPoint:point]];
        
        if (i==0) {
            [path moveToPoint:point];//起点
        }
        
        [path addLineToPoint:point];
    }
    
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
    anmitionLayerLeft = layer;
    
    
}
#pragma mark - 作图 （右侧纵坐标刻度为基准）

-(void)drawRightChartViewWithArrayX:(NSArray *)pathX ArrayY:(NSArray *)pathY andScaleX:(float)X{
    
    [_bottomRightLayer removeAllAnimations];
    [_bottomRightLayer removeFromSuperlayer];
    [self makeRightBottomlayer];
    
    // 创建layer并设置属性
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  2.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor colorFromHexCode:@"fa7a24"].CGColor;
    [_bottomRightLayer addSublayer:layer];
    
    CGPoint point;
    // 创建贝塞尔路径~
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // X轴和Y轴的倍率
    CGFloat BLX = (LABLE_WIDTH-15)/X;
    CGFloat BLY = LABLE_HEIGHT/[[_arrRightY lastObject] floatValue];
    
    for (int i= 0; i< pathY.count; i++) {
        
        CGFloat X = [pathX[i] floatValue]*BLX +(VIEW_WIDTH - LABLE_WIDTH)/2 +10;
        CGFloat Y = LABLE_HEIGHT - [pathY[i] floatValue]*BLY +(VIEW_HEIGHT - LABLE_HEIGHT)/2 +1;//(VIEW_HEIGHT - LABLE_HEIGHT)/2是指图表在背景大图的的height
        
        //NSLog(@"space==%lf",VIEW_HEIGHT - LABLE_HEIGHT);
        point = CGPointMake(X, Y);
        
       // [_pointArr addObject:[NSValue valueWithCGPoint:point]];
        
        if (i==0) {
            [path moveToPoint:point];//起点
        }
        
        [path addLineToPoint:point];
    }
    
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
    anmitionLayerRight = layer;
    
}
#pragma mark -  刷新图表
-(void)refreshChartAnmition{
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(3.0);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    
    // 设置layer的animation
    [anmitionLayerLeft addAnimation:animation forKey:nil];
    
    anmitionLayerLeft.strokeEnd = 1;
    
    
    // 创建Animation
    CABasicAnimation *animationRight = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animationRight.fromValue = @(0.0);
    animationRight.toValue = @(3.0);
    animationRight.autoreverses = NO;
    animationRight.duration = 6.0;
    
    // 设置layer的animation
    [anmitionLayerRight addAnimation:animationRight forKey:nil];
    
    anmitionLayerRight.strokeEnd = 1;

   
}

@end
