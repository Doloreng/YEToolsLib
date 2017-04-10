//
//  Http.m
//  healthManagement
//
//  Created by Eason on 2017/3/10.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "Http.h"
#import "HttpSupport.h"
#define  ERROR_MESSAGE_JSON @"Json解析失败了"
#define ERRER_CODE_JSONECODE -251
@interface Http()
@property(nonatomic, strong) HttpSupport *support;
@end
@implementation Http
-(id)init{
    self = [super init];
    if (self) {
        _support=[[HttpSupport alloc]init];
        [_support setHeadParam:@"IOS" Field:@"OS"];/**< 操作系统 */
//        [_support setHeadParam:[[UIDevice currentDevice] systemVersion] Field:@"OS_VERSION"];/**< 操作系统 */
        [_support setTimeout:15];
    }
    return self;
}
-(void)get:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)errorH{
    
//    __weak typeof(self) wSelf=self;
    [_support getOriginal:host param:dict success:^(id result) {
        //
        NSError *errorJson;
        NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:result
                                                                   options:kNilOptions error:&errorJson];
        if (errorJson) {
            NSLog(@"json解析失败");
            NSError *er = [NSError errorWithDomain:ERROR_MESSAGE_JSON code:ERRER_CODE_JSONECODE userInfo:@{}];
            if (errorH) {
                errorH(er);
            }
        }else{
            if (success) {
                success(resultJSON);
            }
        }
        
    } error:^(NSError *error) {
        //
        if (error&&errorH) {
            errorH(error);
        }
    }];
    
}
-(void)post:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)errorH{
    [_support postOriginal:host param:dict success:^(id result) {
        //
        NSError *errorJson;
        NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:result
                                                                   options:kNilOptions error:&errorJson];
        if (errorJson) {
            NSLog(@"json解析失败");
            NSError *er = [NSError errorWithDomain:ERROR_MESSAGE_JSON code:ERRER_CODE_JSONECODE userInfo:@{}];
            if (errorH) {
                errorH(er);
            }
        }else{
            if (success) {
                success(resultJSON);
            }
        }
    } error:^(NSError *error) {
        //
        if (error&&errorH) {
            errorH(error);
        }
    }];
}

-(void)postFile:(NSString*)host param:(NSDictionary*)dict fileData:(NSData*)aFileData fileName:(NSString*)aFileName type:(NSString*)aType success:(RESULT)success error:(ERROR_H)errorH{
    [_support postOriginalFile:host param:dict fileData:aFileData fileName:aFileName type:aType success:^(id result) {
        //
        NSError *errorJson;
        NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:result
                                                                   options:kNilOptions error:&errorJson];
        if (errorJson) {
            NSLog(@"json解析失败");
            NSError *er = [NSError errorWithDomain:ERROR_MESSAGE_JSON code:ERRER_CODE_JSONECODE userInfo:@{}];
            if (errorH) {
                errorH(er);
            }
        }else{
            if (success) {
                success(resultJSON);
            }
        }
    } error:^(NSError *error) {
        //
        if (error&&errorH) {
            errorH(error);
        }
    }];
}
@end
