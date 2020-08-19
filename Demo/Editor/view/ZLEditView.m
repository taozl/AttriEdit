//
//  ZLEditView.m
//  Demo
//
//  Created by Yuki on 2020/8/18.
//  Copyright © 2020 Zl. All rights reserved.
//

#import "ZLEditView.h"
#import "ToolView.h"//工具栏
#import "ZLAttributeEditTextView.h"

@interface ZLEditView ()

/**  工具栏  **/
@property (nonatomic , strong)ToolView  *toolView;
/**  TextView  **/
@property (nonatomic , strong)ZLAttributeEditTextView  *editTxtView;

@end

static const CGFloat toolViewHeight = 40;

#define navHeight  (UIApplication.sharedApplication.statusBarFrame.size.height + 44)

@implementation ZLEditView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self buildUI];
    }
    return self;
}


#pragma mark - --------- 创建界面  ---------
- (void)buildUI{
    /**  编辑框  **/
    [self addSubview:self.editTxtView];
    self.editTxtView.frame = CGRectMake(10, 10, UIScreen.mainScreen.bounds.size.width - 20, UIScreen.mainScreen.bounds.size.height - navHeight - 20);
    [self addSubview:self.toolView];
    
    /**  监听到键盘出现  **/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    /**  处理点击事件  **/
    [self detailTouchSomthing];
}

#pragma mark - --------- 处理点击事件  ---------
- (void)detailTouchSomthing{
    __weak typeof(self)weakSelf = self;
    /**  获取到工具栏的上回调的图片  **/
    self.toolView.getAttributeImageArrayBlock = ^(NSMutableArray<UIImage *> * _Nonnull attriImgAry) {
        weakSelf.editTxtView.imgArray = attriImgAry ;
    };
}


#pragma mark - --------- 键盘处理  ---------
- (void)keyboardShow:(NSNotification *)notifi{
    /**  键盘出现  **/
    NSDictionary *dic = notifi.userInfo;
    CGRect keyboardFrame = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        self.toolView.frame = CGRectMake(0, (UIScreen.mainScreen.bounds.size.height - keyboardFrame.size.height - navHeight - toolViewHeight), UIScreen.mainScreen.bounds.size.width, toolViewHeight);
        [self bringSubviewToFront:self.toolView];
        //高度需要调节
        CGFloat bottom =0.0;
        if ((self.editTxtView.frame.origin.y + self.editTxtView.frame.size.height) > keyboardFrame.size.height) {
            bottom = ABS((self.editTxtView.frame.origin.y + self.editTxtView.frame.size.height) - (keyboardFrame.size.height)) + 30;
        }else{
            bottom = 0.0;
        }
        self.editTxtView.contentInset = UIEdgeInsetsMake(0, 0,  bottom, 0);
    }];
    
}
- (void)keyboardHidden:(NSNotification *)notifi{
    /**  键盘消失  **/
    [UIView animateWithDuration:0.25 animations:^{
        self.toolView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, toolViewHeight);
        self.editTxtView.contentInset = UIEdgeInsetsMake(0, 0,  0, 0);
        [self bringSubviewToFront:self.toolView];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


#pragma mark - ========= lazy =========
/**  工具栏  **/
- (ToolView *)toolView{
    if (!_toolView) {
        _toolView = [[ToolView alloc]initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, toolViewHeight)];
    }
    return _toolView;
}

/**  文本编辑器  **/
- (UITextView *)editTxtView{
    if (!_editTxtView) {
        _editTxtView = [[ZLAttributeEditTextView alloc]init];
    }
    return _editTxtView;
}

@end
