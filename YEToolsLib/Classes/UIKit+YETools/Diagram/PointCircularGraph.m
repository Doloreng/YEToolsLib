//
//  PointCircularGraph.m
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "PointCircularGraph.h"
#define PI 3.14159265358979323846
@interface PointCircularGraph()
@property (nonatomic, assign) float circularRadius;
@property (nonatomic, strong) UIColor *highColor;
@property (nonatomic, assign) float hightValue;
@end

@implementation PointCircularGraph

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
            PointCircularModel *model=[self.drawRectArray objectAtIndex:i];
            CGFloat dx=model.dx;
            CGFloat dy=model.dy;
            CGPoint point=CGPointMake(dx, dy);
            [self drawArc:point radius:model.radius color:model.color isFill:YES];
        }
    }
}
//对于每个绘制点进行设置
-(LineDiagramModel*)filter:(id)itemValue idx:(NSInteger)idx{
    LineDiagramModel *sourceModel=[super filter:itemValue idx:idx];
    PointCircularModel *model=[PointCircularModel new];
    model.dx=sourceModel.dx;
    model.dy=sourceModel.dy;
    model.radius=self.circularRadius==0?5:self.circularRadius;
    
    float floatItem=[self transformSoureItem:itemValue];
    if (floatItem<self.hightValue) {
        model.color=self.fitColor;
    }else{
        model.color=self.highColor?self.highColor:self.fitColor;
    }
    return model;
}
//设置绘制小圆点的相关信息
-(void)setPointRadius:(float)radius highValue:(float)aHighValue highColor:(UIColor*)ahighColor{
    self.circularRadius=radius;
    self.hightValue=aHighValue;
    self.highColor=ahighColor;
}
//绘制圆形
-(void)drawArc:(CGPoint)point radius:(CGFloat)radius color:(UIColor*)color isFill:(BOOL)isFill{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (isFill) {
        //填充圆，无边框
        CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
        CGContextAddArc(context, point.x, point.y, radius, 0, 2*PI, 0); //添加一个圆
        CGContextDrawPath(context, kCGPathFill);//绘制填充
    }else{
        //边框圆
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineWidth(context, 1.0);//线的宽度
        //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
        // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
        CGContextAddArc(context, point.x, point.y, radius, 0, 2*PI, 0); //添加一个圆
        CGContextDrawPath(context, kCGPathStroke); //绘制路径
    }
}
@end
