//
//  LineGraph.m
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "LineGraph.h"
@interface LineGraph()

@end
@implementation LineGraph

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setSource:(id)source{
    [super setSource:source];
}
//绘制方法
-(void)drawingMethod{
    if (self.drawRectArray.count) {
        for (NSInteger i=0; i<self.drawRectArray.count-1; i++) {
            LineDiagramModel *model=[self.drawRectArray objectAtIndex:i];
            CGFloat s_dx=model.dx;
            CGFloat s_dy=model.dy;
            CGPoint start=CGPointMake(s_dx, s_dy);
            LineDiagramModel *nexModel=[self.drawRectArray objectAtIndex:i+1];
            CGFloat e_dx=nexModel.dx;
            CGFloat e_dy=nexModel.dy;
            CGPoint end=CGPointMake(e_dx, e_dy);
            [self drawLine:self.fitColor startPoint:start endPoint:end isDash:NO];
        }
    }
}
//对于每个绘制点进行设置
-(LineDiagramModel*)filter:(id)itemValue idx:(NSInteger)idx{
    NSArray *tempSource=self.sourceData;
    float itemDrawHeight=self.frame.size.height/self.maxY;
    float itemDrawWidth=self.frame.size.width/tempSource.count;
    float dx=itemDrawWidth/2 +idx*itemDrawWidth;
    
    float floatItem=[self transformSoureItem:itemValue];
    float lineHeight=itemDrawHeight*floatItem;
    float dy=self.frame.size.height-lineHeight;
    LineDiagramModel*model=[LineDiagramModel new];
    model.dx=dx;
    model.dy=dy;
    
    return model;
}

/**
 转换源数据为float
 
 @param itemValue 元数据
 @return float数据
 */
-(float)transformSoureItem:(id)itemValue{
    return  [itemValue floatValue];
}
/**
 绘制线图

 @param color 线图颜色
 @param start 开始Point
 @param end 结束Point
 @param dash 是否是虚线
 */
-(void)drawLine:(UIColor*)color startPoint:(CGPoint)start endPoint:(CGPoint)end isDash:(BOOL)dash{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    //设置线宽为1
    CGContextSetLineWidth(ctx, 1.0);
    if (dash) {
        CGFloat lengths[]={2,2};
        CGContextSetLineDash(ctx, 0, lengths, 2);
    }else{
        CGContextSetLineDash(ctx, 0, 0, 0);
    }
    CGContextMoveToPoint(ctx, start.x, start.y);
    CGContextAddLineToPoint(ctx, end.x, end.y);
    CGContextStrokePath(ctx);
}
@end
