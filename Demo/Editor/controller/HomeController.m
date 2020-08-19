//
//  HomeController.m
//  Demo
//
//  Created by Yuki on 2020/8/18.
//  Copyright © 2020 Zl. All rights reserved.
//

#import "HomeController.h"
#import "ZLEditView.h"//编辑界面

@interface HomeController ()
@end



@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"富文本编辑器";
    
    ZLEditView *editView = [[ZLEditView alloc]init];
    editView.frame = self.view.frame;
    self.view = editView;
    
}


@end
