//
//  BaseRefreshTableViewController.h
//  healthManagement
//
//  Created by Eason on 2017/3/14.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "BaseCellModel.h"
#import "Http.h"

@protocol BaseTableViewControllerDataSource<NSObject>

/**
 列表设置
 
 @param tableView 列表
 */
-(void)tableViewSetting:(UITableView*)tableView;
/**
 请求接口URL
 
 @return url字符串
 */
-(NSString*)requestUrl;

/**
 请求参数
 
 @return 数据请求参数
 */
-(NSDictionary*)requestParam;

/**
 解析数据的key
 
 @return key
 */
-(NSString*)decodeDataWithKey;

/**
 TableView Cell
 
 @param model     数据
 @param tableView 列表
 @param indexPath 选项
 
 @return UITableViewCell
 */
-(UITableViewCell*)createCell:(id)model TableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;

/**
 某一行的数据源
 
 @param dict 元数据
 @param idx 第几行
 @return model
 */
-(BaseCellModel*)modelFromData:(NSDictionary*)dict idx:(NSInteger)idx;
@optional


/**
 数据请求原数据

 @param data 元数据
 */
-(void)sourceData:(NSDictionary*)data;

/**
 tableview headerView
 
 @return UIView
 */
-(UIView*)tableViewHeaderView;

/**
 列表距离上边的距离
 
 @return 高度值
 */
-(CGFloat)tableViewTopHeight;

/**
 列表上部的view
 
 @return uiview
 */
-(UIView*)tableViewTopView;

/**
 是否含有下拉加载
 
 @return bool
 */
-(BOOL)noMJRefreh;
/**
 无数据的时候界面展示
 
 @return UIView
 */
-(UIView*)emptyDataShowView;

/**
 能否删除cell

 @return 是否
 */
-(BOOL)canDeleteCell;
@end

@protocol BaseTableViewControllerDelegate <NSObject>



@optional
/**
 列表点击某行
 
 @param model 数据
 */
-(void)cellSelectModel:(id)model;
-(void)cellDeleteModel:(id)model;
@end

@interface BaseRefreshTableViewController : BaseViewController
@property (nonatomic, weak) id<BaseTableViewControllerDataSource>baseDataSource;
@property (nonatomic, weak) id<BaseTableViewControllerDelegate>baseDelegate;
@end
