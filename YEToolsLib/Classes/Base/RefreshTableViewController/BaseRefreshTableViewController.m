//
//  BaseRefreshTableViewController.m
//  healthManagement
//
//  Created by Eason on 2017/3/14.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseRefreshTableViewController.h"

@interface BaseRefreshTableViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewControllerDelegate,BaseTableViewControllerDataSource>
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isNextPage;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSDictionary *source;
@property (nonatomic, assign) BOOL isRefreshOrNextAt;
@end

@implementation BaseRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)tableViewSetting:(UITableView*)tableView{
    
}
-(NSString*)requestUrl{
    return @"";
}
-(NSDictionary*)requestParam{
    return @{};
}
-(NSString*)decodeDataWithKey{
    return  @"";
}
-(UITableViewCell*)createCell:(id)model TableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(BaseCellModel*)modelFromData:(NSDictionary*)dict idx:(NSInteger)idx{
    BaseCellModel *model=[BaseCellModel new];
    return model;
}
-(void)setupTableView{
    self.isRefresh=YES;
    self.mTableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.mTableView.delegate=self;
    self.mTableView.dataSource=self;
    [self.view addSubview:self.mTableView];
    CGRect frame = self.view.frame;
    
    CGFloat y=0;
    if ([self.baseDataSource respondsToSelector:@selector(tableViewTopHeight)]) {
        y=[self.baseDataSource tableViewTopHeight];
    }
    frame.origin.y=y;
    frame.size.height = frame.size.height -y;
    self.mTableView.frame = frame;
    self.listArray=[[NSMutableArray alloc]init];
    
    __weak const typeof(self) block=self;
    if([self conformsToProtocol:@protocol(BaseTableViewControllerDataSource)]){
        self.baseDataSource=block;
    }
    if ([self conformsToProtocol:@protocol(BaseTableViewControllerDelegate)]) {
        self.baseDelegate=block;
    }
    //    [self.mTableView.mj_header beginRefreshing];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if([self.baseDataSource respondsToSelector:@selector(tableViewSetting:)]){
        [self.baseDataSource tableViewSetting:self.mTableView];
    }
    if ([self.baseDataSource respondsToSelector:@selector(tableViewHeaderView)]) {
        UIView *view=[self.baseDataSource tableViewHeaderView];
        if (view) {
            [self.mTableView beginUpdates];
            [self.mTableView setTableHeaderView:view];
            [self.mTableView endUpdates];
        }
    }
    if ([self.baseDataSource respondsToSelector:@selector(tableViewTopView)]) {
        UIView *view=[self.baseDataSource tableViewTopView];
        if (view) {
            [self.view addSubview:view];
        }
        
    }
    
    [self isNoMJrefreshDataSource];

}
//无下拉刷新的状态
-(void)isNoMJrefreshDataSource{
    BOOL have=NO;
    if ([self.baseDataSource respondsToSelector:@selector(noMJRefreh)]) {
        have=![self.baseDataSource noMJRefreh];
        
    }
    if (have) {
        self.mTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //
            if (!self.isRefresh&&!self.isNextPage) {
                [self refreshList];
            }
            
        }];
        self.mTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //
            if (!self.isRefresh&&!self.isNextPage) {
                [self nextList];
            }
        }];
    }else{
        [self refreshList];
    }
}
//刷新列表
-(void)refreshList{
    self.isNextPage=NO;
    self.isRefresh=YES;
    self.isRefreshOrNextAt=YES;
    _pageNum=1;
    [self requestList];
}
//下一页
-(void)nextList{
    self.isNextPage=YES;
    self.isRefresh=NO;
    self.isRefreshOrNextAt=NO;
    _pageNum+=1;
    [self requestList];
}
//结束刷新或加载新
-(void)endHeaderOrFooter{
    if (!self.baseDataSource||[self.baseDataSource noMJRefreh]) {
        return;
    }
    if (self.isRefresh) {
        self.isRefresh=NO;
        //        [self.listVc headerEndRefreshing];
        [self.mTableView.mj_header endRefreshing];
    }
    if (self.isNextPage) {
        self.isNextPage=NO;
        //        [self.listVc footerEndRefreshing];
        [self.mTableView.mj_footer endRefreshing];
    }
}
-(void)decodeData:(NSDictionary*)data{
    //    NSLog(@"list source Data %@",data);
    self.source=data;
    if (self.baseDataSource&&[self.baseDataSource respondsToSelector:@selector(sourceData:)]) {
        [self.baseDataSource sourceData:data];
    }
    NSString *key=@"Data";
    if ([self.baseDataSource respondsToSelector:@selector(decodeDataWithKey)]) {
        key=[self.baseDataSource decodeDataWithKey]==nil?key:[self.baseDataSource decodeDataWithKey];
    }
    NSArray *array=[data objectForKey:key];
    //    NSLog(@"list arr %@",array);
    NSMutableArray *muarr=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<array.count; i++) {
        NSDictionary *item=array[i];
        if ([self.baseDataSource respondsToSelector:@selector(modelFromData:idx:)]) {
            BaseCellModel *model=[self.baseDataSource modelFromData:item idx:i];
            model.sourceDict=item;
            if (model) {
                [muarr addObject:model];
            }
            
        }
    }
    if (self.isRefresh) {
        self.listArray=muarr;
    }
    if (self.isNextPage) {
        [self.listArray addObjectsFromArray:muarr];
    }
    [self.mTableView reloadData];
    
}


/**
 发送请求
 */
-(void)requestList{
    NSString *pageSize=@"20";
    NSString *page=[NSString stringWithFormat:@"%li",(long)_pageNum];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:page,@"Page",pageSize,@"PageSize", nil];
    NSString *urlstr=[self.baseDataSource requestUrl];
    if (!urlstr) {
        urlstr=@"";
    }
    if ([self.baseDataSource respondsToSelector:@selector(requestParam)]) {
        NSDictionary *param=[self.baseDataSource requestParam];
        if (param) {
            [dict addEntriesFromDictionary:param];
        }
        
    }
    
    __weak typeof(self) bSelf=self;
    Http *http=[Http init];
    [http get:urlstr param:dict success:^(NSDictionary *result) {
        //
        [bSelf decodeData:result];
        [bSelf endHeaderOrFooter];
    } error:^(NSError *errorH) {
        //
        [bSelf endHeaderOrFooter];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellModel *model=[self.listArray objectAtIndex:indexPath.row];
    return [model cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCellModel *model=[self.listArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell =[self.baseDataSource createCell:model TableView:tableView IndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellModel *model=[self.listArray objectAtIndex:indexPath.row];
    if ([self.baseDelegate respondsToSelector:@selector(cellSelectModel:)]) {
        [self.baseDelegate cellSelectModel:model];
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.baseDataSource respondsToSelector:@selector(canDeleteCell)]) {
        return [self.baseDataSource canDeleteCell];
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self.baseDelegate respondsToSelector:@selector(cellDeleteModel:)]) {
            [self.baseDelegate cellDeleteModel:[self.listArray objectAtIndex:indexPath.row]];
        }
        [self.listArray removeObjectAtIndex:indexPath.row];
        [self.mTableView reloadData];
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

@end
