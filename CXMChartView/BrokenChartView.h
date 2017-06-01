//
//  BrokenChartView.h
//  AseanData
//
//  Created by 陈小明 on 2017/4/25.
//  Copyright © 2017年 wanshenglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokenChartView : UIView

/*
 * X 轴的刻度数字
 */
@property (nonatomic,strong)NSArray *arrX;

/*
 * Y 轴的刻度数字 左侧纵轴的刻度
 */
@property (nonatomic,strong)NSArray *arrLeftY;

/*
 * Y 轴的刻度数字 右侧纵轴的刻度
 */
@property (nonatomic,strong)NSArray *arrRightY;

/*
 * 刷新数据 重新开始动画
 */
-(void)refreshChartAnmition;

/* 根据数据源画图
 *  pathX :横坐标数据
 *  纵坐标 右侧刻度基准
 *  pathY :纵坐标数据源
 */
-(void)drawRightChartViewWithArrayX:(NSArray*)pathX ArrayY:(NSArray*)pathY andScaleX:(float)X;

/* 根据数据源画图
 *  pathX :横坐标数据
 *  纵坐标 左侧刻度基准
 *  pathY :纵坐标数据源
 */
-(void)drawLeftChartViewWithArrayX:(NSArray*)pathX ArrayY:(NSArray*)pathY andScaleX:(float)X;

@end
