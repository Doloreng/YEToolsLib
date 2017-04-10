//
//  BaseViewController.m
//  healthManagement
//
//  Created by Eason on 2017/3/8.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, retain) UIView *keyboardMoveView;
@property (nonatomic, assign) CGFloat keyboardMoveHeight;
@property (assign, nonatomic) CGRect originalViewFrame;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//设置标题文字颜色
-(void)setNaviTitleColor:(UIColor*)color fontName:(NSString*)fontName size:(float)size{
    if (!color) {
        color=[UIColor whiteColor];
    }
    UIFont *font=[UIFont boldSystemFontOfSize:size];
    if (fontName) {
        font=[UIFont fontWithName:fontName size:size];
    }
    
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:color,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
}
//设置navi背景图片或者颜色
-(void)setNaviBarBackColorWithImage:(NSString*)imageName orColor:(UIColor*)color{
    self.navigationController.navigationBar.translucent=NO;
    if (!imageName) {
        [self.navigationController.navigationBar setBarTintColor:color];
    }else{
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)borderView:(UIView*)view cornerRadius:(float)cornerRadius borderColor:(CGColorRef)borderColor{
    if (!borderColor) {
        borderColor=[UIColor clearColor].CGColor;
    }
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=cornerRadius;
    //    view.layer.borderWidth=borderWidth;
    view.layer.borderColor=borderColor;
}
-(void)createBackOfNavi{
    [self createLeftBackWithString:@"返回" img:nil];
}
-(void)createLeftBackWithString:(NSString*)title img:(UIImage*)img{
    [self createLeftBarButtonCustomItem:title Img:img Select:@"backPressed:" Margin:@2 Rect:CGRectMake(0, 0, 44, 44)];
}

-(void)createLeftBarButtonCustomItem:(NSString *)content Img:(UIImage *)img Select:(NSString*)method Margin:(NSNumber*)margin Rect:(CGRect)bound{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    leftBtn.titleLabel.font = [UIFont fontWithName:DEFAULTFONTNAME size:15.0f];
    [leftBtn setFrame:bound];
    [leftBtn setTitle:content forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (img) {
        [leftBtn setImage:img forState:UIControlStateNormal];
    }
    SEL mo = NSSelectorFromString(method);
    [leftBtn addTarget:self action:mo forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = margin.intValue;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backItem, nil];;
}

-(void)createRightBarButtonCustomItem:(NSString *)content Img:(UIImage *)img Select:(NSString*)method Margin:(NSNumber*)margin Rect:(CGRect)bound{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.titleLabel.font = [UIFont fontWithName:DEFAULTFONTNAME size:15.0f];
    [rightBtn setFrame:bound];
    [rightBtn setTitle:content forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (img) {
        [rightBtn setImage:img forState:UIControlStateNormal];
    }
    SEL mo = NSSelectorFromString(method);
    [rightBtn addTarget:self action:mo forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = margin.intValue;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backItem, nil];;
}
/**
 返回按钮点击事件
 
 @param sender 按钮
 */
-(void)backPressed:(id)sender{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//返回storyboard

/**
 根据storyboard的名称获取storyboard
 
 @param name 名称
 @return storyboard
 */
-(UIStoryboard*)storyBoardWithName:(NSString*)name{
    UIStoryboard *main=[UIStoryboard storyboardWithName:name bundle:nil];
    
    return main;
}
/**
 设置navigation bar 可见
 
 @param hiden 隐藏或者显示
 */
-(void)hidenNavigationBar:(BOOL)hiden{
    [self.navigationController setNavigationBarHidden:hiden];
}
//设置键盘移动的view的基础数值
-(void)setKeyboardMoveView:(UIView *)keyboardMoveView{
    _keyboardMoveView=keyboardMoveView;
    _originalViewFrame=keyboardMoveView.frame;
}
/**
 添加键盘移动通知事件
 */
-(void)addKeyboardMoveNotify{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 移除键盘移动通知事件
 */
-(void)removeKeyboardMoveNotify{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark keybard move
//键盘通知事件
- (void)keyboardWillShow:(NSNotification*)notification {
    [self selfViewAnimation:notification up:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    [self selfViewAnimation:notification up:NO];
}

//随键盘移动的动画
-(void)selfViewAnimation:(NSNotification*)notify up:(BOOL)isUp{
    NSDictionary *userInfo = [notify userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardRect;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    UIView *moveview=self.keyboardMoveView?self.keyboardMoveView:self.view;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    if (isUp) {
        CGFloat keyboardTop = keyboardRect.size.height;
        if (_originalViewFrame.size.width==0) {
            _originalViewFrame=moveview.frame;
        }
        CGRect newFram = _originalViewFrame;
        if (self.keyboardMoveHeight==0) {
            newFram.origin.y=newFram.origin.y-keyboardTop;
        }else{
            newFram.origin.y=newFram.origin.y-self.keyboardMoveHeight;
        }
        
        moveview.frame=newFram;
    }else {
        moveview.frame=_originalViewFrame;
    }
    [UIView commitAnimations];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
