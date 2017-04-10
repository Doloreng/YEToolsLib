//
//  HttpHUD.h
//  healthManagement
//
//  Created by Eason on 2017/3/21.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "Http.h"
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
@interface HttpHUD : Http

/**
 Get请求

 @param host host
 @param dict 参数
 @param success 成功回调
 @param aError 失败回调
 @param aShowView 展示缓冲的view
 */
-(void)get:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)aError showView:(UIView*)aShowView;


/**
 POST请求

 @param host host
 @param dict 参数
 @param success 成功回调
 @param aError 失败回调
 @param aShowView 展示缓冲的View
 */
-(void)post:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)aError showView:(UIView*)aShowView;

/**
 POST请求附带文件数据

 @param host host
 @param dict 参数
 @param aFileData 文件数据
 @param aFileName 文件名称
 @param aType 文件类型
 @param success 成功
 @param aError 失败
 */
-(void)postFile:(NSString*)host param:(NSDictionary*)dict fileData:(NSData*)aFileData fileName:(NSString*)aFileName type:(NSString*)aType success:(RESULT)success error:(ERROR_H)aError showView:(UIView*)aShowView;
@end
