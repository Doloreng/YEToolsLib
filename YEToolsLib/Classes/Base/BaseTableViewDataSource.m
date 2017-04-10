//
//  BaseTableViewDataSource.m
//  healthManagement
//
//  Created by Eason on 2017/3/14.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseTableViewDataSource.h"
@interface BaseTableViewDataSource()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy) TableViewCellSelectBlock selectCellBlock;
@end
@implementation BaseTableViewDataSource
- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock selectCellBlock:(TableViewCellSelectBlock)aSelectCellBlock{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.selectCellBlock=[aSelectCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id item= [self.items objectAtIndex:indexPath.row];
    if (self.selectCellBlock) {
        self.selectCellBlock(item,indexPath);
    }
    
}
@end
