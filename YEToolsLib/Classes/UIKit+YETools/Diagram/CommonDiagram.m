//
//  CommonDiagram.m
//  healthManagement
//
//  Created by Eason on 2017/3/15.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "CommonDiagram.h"
@interface CommonDiagram()

@end
@implementation CommonDiagram

-(id)initWithFrame:(CGRect)frame fitColor:(UIColor*)aFitColor backGroundColor:(UIColor*)aBackGroundColor itemOffset:(CGFloat)aItemOffset;{
    self=[super initWithFrame:frame];
    if (self) {
        self.fitColor=aFitColor;
        self.backgroundColor=aBackGroundColor;
        self.itemOffset=aItemOffset;
    }
    return self;
}
-(void)setSource:(id)source{
    _sourceData=source;
    _drawRectArray=[self filterSourceData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect{
    if (self.fitColor&&self.drawRectArray) {
        [self drawingMethod];
    }
}
-(void)drawingMethod{
    
}
/**
过滤数据
*/
-(NSArray*)filterSourceData{
    if ([self sourceIsArray]) {
        NSArray *sArr=self.sourceData;
        float max =[self filterSourceDataForMaxValue];
        self.maxY=max;
        
        if (max<=0.0) {
            return [NSArray new];
        }
        NSMutableArray *drawMuArr=[[NSMutableArray alloc] initWithCapacity:1];
        for (NSInteger i=0; i<sArr.count; i++) {
            id itemValueY=sArr[i];
            LineDiagramModel*model=[self filter:itemValueY idx:i];
            [drawMuArr addObject:model];
        }
        return [drawMuArr copy];
    }
    
    return [NSArray new];
}
-(float)filterSourceDataForMaxValue{
    float max = 0.0;
    NSArray *sArr=self.sourceData;
    for (id item in sArr) {
        float itemValue=[item floatValue];
        if (itemValue>=max) {
            max=itemValue;
        }
    }
    max=max+max*TopMaxValueSpacePercent;
    return max;

}

-(LineDiagramModel*)filter:(id)itemValue idx:(NSInteger)idx{
    LineDiagramModel*model=[LineDiagramModel new];
    
    return model;
}
/**
 是否是数组
 
 @return BOOL
 */
-(BOOL)sourceIsArray{
    if (_sourceData) {
        if ([_sourceData isKindOfClass:[NSArray class]]||[_sourceData isKindOfClass:[NSMutableArray class]]) {
            NSArray *temp=_sourceData;
            if (temp.count>0) {
                return YES;
            }
        }
    }
    return NO;
}
@end
