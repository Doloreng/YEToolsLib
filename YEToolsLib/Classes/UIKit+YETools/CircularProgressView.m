//
//  CircularProgressView.m
//  healthManagement
//
//  Created by yangxiaohui on 2017/3/14.
//  Copyright © 2017年 yxh. All rights reserved.
//

#import "CircularProgressView.h"

@implementation CircularProgressView

- (void)drawRect:(CGRect)rect {
    
    [self drawRoundProgress];
}

-(void)drawRoundProgress{
    // 偏移率
    CGFloat offsetRate;
    // 圆弧起点
    CGFloat startA = 0.0;
    // 圆弧终点
    CGFloat endA = 0.0;
    CGFloat aOffset;
    
    offsetRate = (100.0 - _offset)/100.0;
    
    CGFloat angle = _completeNum * offsetRate/ 100.0 * M_PI * 2;
    aOffset = _offset / 100.0 * M_PI;
    // 圆弧转向
    BOOL direction = NO;
    
    switch (_clockDirection) {
        case DIRECTION_TOP_ACS:
            startA = 75 / 100.0 * M_PI * 2 + aOffset;
            endA = startA + angle;
            direction = YES;
            break;
        case DIRECTION_TOP_DESC:
            startA = 75 / 100.0 * M_PI * 2 - aOffset;
            endA = startA - angle;
            direction = NO;
            break;
        case DIRECTION_BOTTOM_ASC:
            startA = 25 / 100.0 * M_PI * 2 + aOffset;
            endA = startA + angle;
            direction = YES;
            break;
        case DIRECTION_BOTTOM_DESC:
            startA = 25 / 100.0 * M_PI * 2 - aOffset;
            endA = startA - angle;
            direction = NO;
            break;
            
        default:
            break;
    }
    
    // 背景圆弧
    
    CGPoint center =  CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = self.bounds.size.width * 0.5 - 10;
    UIColor * bgColor = [UIColor clearColor];
    if (_backColor !=nil) {
        bgColor = _backColor;
    }
    CGContextRef ctx1 = UIGraphicsGetCurrentContext();
    CGFloat endAngle = 100 * offsetRate/ 100.0 * M_PI * 2;
    UIBezierPath  *backGroundPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:startA + endAngle clockwise:direction];
    CGContextSetLineWidth(ctx1, 10);
    CGContextAddPath(ctx1, backGroundPath.CGPath);
    [bgColor set];
    if (_isRound) {
        CGContextSetLineJoin(ctx1, kCGLineJoinRound);
        CGContextSetLineCap(ctx1, kCGLineCapRound);
    }
    
    CGContextStrokePath(ctx1);
    
    // 进度圆弧
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath  *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:direction];
    CGContextSetLineWidth(ctx, 10);
    [_LineColor set];
    if (_isRound) {
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
        CGContextSetLineCap(ctx, kCGLineCapRound);
    }
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    
    
}

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor completeNum:(CGFloat)num{
    
    if (self = [super initWithFrame:frame]) {
        _LineColor = lineColor;
        _completeNum = num;
        
    }
    
    self.backgroundColor=[UIColor clearColor];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end
