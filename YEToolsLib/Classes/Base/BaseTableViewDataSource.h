//
//  BaseTableViewDataSource.h
//  healthManagement
//
//  Created by Eason on 2017/3/14.
//  Copyright © 2017年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^TableViewCellConfigureBlock)(id cell, id item);
typedef void(^TableViewCellSelectBlock)(id item,NSIndexPath *idxPath);
@interface BaseTableViewDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

/**
 初始化列表代理

 @param anItems 源数据数组
 @param aCellIdentifier CellIdentifier
 @param aConfigureCellBlock cell配置回调
 @param aSelectCellBlock cell点击回调
 @return 返回对象实例
 */
- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock selectCellBlock:(TableViewCellSelectBlock)aSelectCellBlock;

/**
 返回源数据的任意一个

 @param indexPath idexPath
 @return 数据
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
