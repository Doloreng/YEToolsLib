//
//  PointCircularGraph.h
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "LineGraph.h"
#import "PointCircularModel.h"
@interface PointCircularGraph : LineGraph

/**
 设置绘制小圆点的相关信息

 @param radius 半径
 @param aHighValue 高位值
 @param ahighColor 高位颜色
 */
-(void)setPointRadius:(float)radius highValue:(float)aHighValue highColor:(UIColor*)ahighColor;
@end
