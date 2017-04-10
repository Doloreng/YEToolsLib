//
//  BaseCellModel.h
//  healthManagement
//
//  Created by Eason on 2017/3/14.
//  Copyright © 2017年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface BaseCellModel : NSObject
@property (nonatomic, strong)NSDictionary*sourceDict;
-(float)cellHeight;

@end
