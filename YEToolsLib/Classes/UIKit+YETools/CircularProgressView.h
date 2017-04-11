//
//  CircularProgressView.h
//  healthManagement
//
//  Created by yangxiaohui on 2017/3/14.
//  Copyright © 2017年 yxh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum DIRECTION{
    DIRECTION_TOP_ACS = 0, // 从顶部顺时针转
    DIRECTION_TOP_DESC,     //从顶部逆时针转
    DIRECTION_BOTTOM_ASC,    //从底部顺时针转
    DIRECTION_BOTTOM_DESC,    //从底部逆时针转
}DIRECTION;
@interface CircularProgressView : UIView
@property(nonatomic ,strong) UIColor * LineColor; // 线条颜色
@property(nonatomic,strong) UIColor * backColor; // 线条背景色
@property(nonatomic ,assign) CGFloat completeNum;//进度
@property(nonatomic ,assign) NSInteger clockDirection;//转向
@property(nonatomic ,assign) BOOL isRound;   // 圆弧形是否为圆角
@property(nonatomic,assign) CGFloat offset; // 偏移量(0~100)
// 绘制圆形进度条
-(void)drawRoundProgress;

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor completeNum:(CGFloat)num;
@end
