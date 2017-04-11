//
//  LowHightHistogram.m
//  healthManagement
//
//  Created by Eason on 2017/3/16.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "LowHightHistogram.h"
@interface LowHightHistogram()
@property(nonatomic, assign)float drawRectRadius;
@end
@implementation LowHightHistogram

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawingMethod{
    if (self.drawRectArray.count) {
        for (NSInteger i=0; i<self.drawRectArray.count; i++) {
            HistogramModel *model=[self.drawRectArray objectAtIndex:i];
            CGFloat dx=model.dx;
            CGFloat dy=model.dy;
            CGFloat dw=model.dWidth;
            CGFloat dh=model.dHeight;
            CGRect rect=CGRectMake(dx, dy, dw, dh);
            CGFloat radius=self.drawRectRadius?self.drawRectRadius:10;
            [self drawRoundRect:rect color:self.fitColor radius:radius];
        }
    }
    
}

//过滤获取最大数据值
-(float)filterSourceDataForMaxValue{
    float max = 0.0;
    NSArray *sArr=self.sourceData;
    for (id item in sArr) {
        NSArray *tempArr=item;
        float highValue=[tempArr[0] floatValue];
        if (highValue>=max) {
            max=highValue;
        }
    }
    max=max+max*TopMaxValueSpacePercent;
    return max;
}

//对于每个绘制点进行设置
-(LineDiagramModel*)filter:(id)itemValue idx:(NSInteger)idx{
    NSArray *tempArr=[self transformSoureItemToArray:itemValue];
    float itemDrawHeight=self.frame.size.height/self.maxY;
    float highValue=[tempArr[0] floatValue];
    float lowValue=[tempArr[1] floatValue];
    
    HistogramModel *smodel=(HistogramModel*)[super filter:[NSNumber numberWithFloat:highValue] idx:idx];
    LowHeightHistogramModel *model=[LowHeightHistogramModel new];
    model.dx=smodel.dx;
    model.dy=smodel.dy;
    model.dWidth=smodel.dWidth;
    model.dHeight=smodel.dHeight-lowValue*itemDrawHeight;
    
    return model;
}

-(void)setRectRadius:(float)rectRadius{
    self.drawRectRadius=rectRadius;
}
/**
 转换为Array
 
 @param itemValue 原始数据
 @return 数组
 */
-(NSArray*)transformSoureItemToArray:(id)itemValue{
    NSArray *temp=itemValue;
    return  temp;
}
//绘制圆角矩形
-(void)drawRoundRect:(CGRect)rect color:(UIColor*)color radius:(CGFloat)radius{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    //画圆矩形
    
    //设置线宽
    CGContextSetLineWidth(ctx, 1.0);
    
    //设置填充颜色和画笔颜色
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    
    
    CGPathRef clippath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;
    CGContextAddPath(ctx, clippath);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}
@end
