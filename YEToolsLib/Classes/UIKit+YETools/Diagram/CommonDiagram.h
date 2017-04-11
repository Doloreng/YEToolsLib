//
//  CommonDiagram.h
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseDiagram.h"
#import "LineDiagramModel.h"
#define TopMaxValueSpacePercent 0.1

@interface CommonDiagram : BaseDiagram
@property(nonatomic, strong) UIColor *fitColor;     //填充颜色
@property(nonatomic, assign) CGFloat itemOffset;    //偏移量
@property(nonatomic, assign) CGFloat maxY;        //最高值
@property(nonatomic, readonly) NSArray *drawRectArray;//绘制的数据
@property(nonatomic, readonly) id sourceData;         //源数据
/**
 初始化
 
 @param frame Frame
 @param aFitColor 填充颜色
 @param aBackGroundColor 背景色
 @param aItemOffset 间距
 @return 实例
 */
-(id)initWithFrame:(CGRect)frame fitColor:(UIColor*)aFitColor backGroundColor:(UIColor*)aBackGroundColor itemOffset:(CGFloat)aItemOffset;

/**
 循环处理每个数据获得绘制model

 @param itemValue 源数据某一项的值
 @return 绘制model
 */
-(LineDiagramModel*)filter:(id)itemValue idx:(NSInteger)idx;

/**
 过滤原始数据获取最大的绘制值

 @return 最大绘制值
 */
-(float)filterSourceDataForMaxValue;
@end
