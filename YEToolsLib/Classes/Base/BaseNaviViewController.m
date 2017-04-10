//
//  BaseNaviViewController.m
//  healthManagement
//
//  Created by Eason on 2017/3/27.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface BaseNaviViewController ()

@end

@implementation BaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self= [super initWithRootViewController:rootViewController];
    if (self) {
        self.rootVc=rootViewController;
    }
    return self;
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

@end
