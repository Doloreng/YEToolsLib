//
//  Histogram.m
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "Histogram.h"
@interface Histogram()

@end
@implementation Histogram


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
            [self drawRectangle:rect color:self.fitColor isFill:YES];
        }
    }
    
}
//对于每个绘制点进行设置
-(LineDiagramModel*)filter:(id)itemValue idx:(NSInteger)idx{
    
    NSArray *tempSource=self.sourceData;
    float itemDrawHeight=self.frame.size.height/self.maxY;
    float itemDrawWidth=self.frame.size.width/tempSource.count;
    float hisItemDrawWidth =itemDrawWidth-self.itemOffset;
    //
    float dx=self.itemOffset/2 +idx*itemDrawWidth;
    //
    float floatItem=[self transformSoureItem:itemValue];
    float lineHeight=itemDrawHeight*floatItem;
    float dy=self.frame.size.height-lineHeight;
    CGFloat dh=lineHeight;
    
    HistogramModel *model=[HistogramModel new];
    model.dx=dx;
    model.dy=dy;
    model.dWidth=hisItemDrawWidth;
    model.dHeight=dh;
    return model;
}


/**
 绘制矩形

 @param rect Rect
 @param color 颜色
 @param isFill 是否填充
 */
-(void)drawRectangle:(CGRect)rect color:(UIColor *)color isFill:(BOOL)isFill{
    CGMutablePathRef path = CGPathCreateMutable();
    
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rect);
    //获取上下文
    CGContextRef currentContext =UIGraphicsGetCurrentContext();
    
    //将路径添加到上下文
    CGContextAddPath(currentContext, path);
    
    //设置矩形填充色
    [color setFill];
    
    //矩形边框颜色
    [color setStroke];
    
    //边框宽度
    CGContextSetLineWidth(currentContext,1.0f);
    
    //绘制
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);
}




@end
