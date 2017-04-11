//
//  BaseDiagram.h
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDiagram : UIView

/**
 设置源数据

 @param source 源数据
 */
-(void)setSource:(id)source;

/**
 设置画法
 */
-(void)drawingMethod;

//使用默认的重绘方式绘制
@end
