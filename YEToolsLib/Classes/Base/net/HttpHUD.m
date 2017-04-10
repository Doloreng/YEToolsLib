//
//  HttpHUD.m
//  healthManagement
//
//  Created by Eason on 2017/3/21.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "HttpHUD.h"

@implementation HttpHUD

-(void)get:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)aError showView:(UIView*)aShowView{
//    [self get:host param:dict success:success error:errorH];
    if (aShowView) {
        [SVProgressHUD show];
    }
    [self get:host param:dict success:^(NSDictionary *result) {
        //
        if (aShowView) {
            [SVProgressHUD dismiss];
        }
        if (success) {
            success(result);
        }
    } error:^(NSError *errorH) {
        //
        if (aShowView) {
            [SVProgressHUD dismiss];
        }
        if (aError) {
            aError(errorH);
        }
    }];
}
-(void)post:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)aError showView:(UIView*)aShowView{
    if (aShowView) {
        [SVProgressHUD show];
    }
    [self post:host param:dict success:^(NSDictionary *result) {
        //
        if (aShowView) {
            [SVProgressHUD dismiss];
        }
        if (success) {
            success(result);
        }
    } error:^(NSError *errorH) {
        //
        if (aShowView) {
            [SVProgressHUD dismiss];
        }
        if (aError) {
            aError(errorH);
        }
    }];
}
-(void)postFile:(NSString*)host param:(NSDictionary*)dict fileData:(NSData*)aFileData fileName:(NSString*)aFileName type:(NSString*)aType success:(RESULT)success error:(ERROR_H)aError showView:(UIView*)aShowView{
    if (aShowView) {
        [SVProgressHUD show];
    }
    [self postFile:host param:dict fileData:aFileData fileName:aFileName type:aType success:^(NSDictionary *result) {
        //
        if (aShowView) {
            [SVProgressHUD dismiss];
        }
        if (success) {
            success(result);
        }
    } error:^(NSError *errorH) {
        //
        if (aShowView) {
            [SVProgressHUD dismiss];
        }
        if (aError) {
            aError(errorH);
        }
    }];
}
@end
