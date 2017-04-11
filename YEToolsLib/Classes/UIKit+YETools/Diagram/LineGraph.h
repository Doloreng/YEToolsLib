//
//  LineGraph.h
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "CommonDiagram.h"
@interface LineGraph :CommonDiagram
/**
 转换源数据为float
 
 @param itemValue 元数据
 @return float数据
 */
-(float)transformSoureItem:(id)itemValue;
@end
