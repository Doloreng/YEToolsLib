//
//  BaseViewController.h
//  healthManagement
//
//  Created by Eason on 2017/3/8.
//  Copyright © 2017年 eason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
@interface BaseViewController : UIViewController


/**
 返回按钮点击事件

 @param sender 按钮
 */
-(void)backPressed:(id)sender;
//返回storyboard

/**
 根据storyboard的名称获取storyboard

 @param name 名称
 @return storyboard
 */
-(UIStoryboard*)storyBoardWithName:(NSString*)name;
/**
 设置navigation bar 可见

 @param hiden 隐藏或者显示
 */
-(void)hidenNavigationBar:(BOOL)hiden;

/**
 添加键盘移动通知事件
 */
-(void)addKeyboardMoveNotify;

/**
 移除键盘移动通知事件
 */
-(void)removeKeyboardMoveNotify;

/**
 设置键盘移动的基础view

 @param keyboardMoveView view
 */
-(void)setKeyboardMoveView:(UIView *)keyboardMoveView;

/**
 创建返回按钮 navi

 @param title 标题
 @param img 图片
 */
-(void)createLeftBackWithString:(NSString*)title img:(UIImage*)img;

/**
 创建左边的navigationbar上的按钮

 @param content 标题
 @param img 图片
 @param method 方法名称字符串
 @param margin 间距
 @param bound 宽高
 */
-(void)createLeftBarButtonCustomItem:(NSString *)content Img:(UIImage *)img Select:(NSString*)method Margin:(NSNumber*)margin Rect:(CGRect)bound;

/**
 创建右边的navigationbar上的按钮

 @param content 标题
 @param img 图片
 @param method 方法名称的字符串
 @param margin 间距
 @param bound 宽高
 */
-(void)createRightBarButtonCustomItem:(NSString *)content Img:(UIImage *)img Select:(NSString*)method Margin:(NSNumber*)margin Rect:(CGRect)bound;

/**
 创建默认navigationBar左侧返回
 */
-(void)createBackOfNavi;

/**
 设置view的圆角

 @param view 目标view
 @param cornerRadius 圆角大小
 @param borderColor 圆角颜色
 */
-(void)borderView:(UIView*)view cornerRadius:(float)cornerRadius borderColor:(CGColorRef)borderColor;

/**
 设置导航器标题的颜色和字体大小

 @param color 颜色
 @param fontName 字体
 @param size 字体大小
 */
-(void)setNaviTitleColor:(UIColor*)color fontName:(NSString*)fontName size:(float)size;

/**
 设置导航器背景或者背景色

 @param imageName 图片名称
 @param color 颜色
 */
-(void)setNaviBarBackColorWithImage:(NSString*)imageName orColor:(UIColor*)color;
@end
