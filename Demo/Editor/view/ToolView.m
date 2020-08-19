//
//  ToolView.m
//  Demo
//
//  Created by Yuki on 2020/8/18.
//  Copyright © 2020 Zl. All rights reserved.
//

#import "ToolView.h"

@interface ToolView ()
/**  添加图片按钮  **/
@property (nonatomic , strong)UIButton  *addImgBtn;
@end
@implementation ToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = UIColor.lightGrayColor.CGColor;
        self.layer.borderWidth = 1;
        [self buildUI];
    }
    return self;
}

/**  创建界面  **/
- (void)buildUI{
    /**  添加图片  **/
    [self addSubview:self.addImgBtn];
    self.addImgBtn.frame = CGRectMake(10, 5, 70, 30);
    //获取图片点击事件
    [self.addImgBtn addTarget:self action:@selector(addAndChoseImg) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - --------- 点击获取图片事件  ---------
- (void)addAndChoseImg{
    NSMutableArray *imgAry = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        /**
         这里要处理好图片的大小，尺寸，宽度建议是编辑器的宽度 -10 ;
         **/
        
        img = [self imageResize:img andResizeTo:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30, 200)];
        [imgAry addObject:img];
    }
    
    
    if (self.getAttributeImageArrayBlock) {
        self.getAttributeImageArrayBlock(imgAry);
    }
}

//MARK:工具方法
/**  修改UIImage 的 size  **/
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
 
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



#pragma mark - ========= lazy =========
/**  添加图片按钮  **/
- (UIButton *)addImgBtn{
    if (!_addImgBtn) {
        _addImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImgBtn setTitle:@"添加图片" forState:UIControlStateNormal];
        _addImgBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addImgBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        return _addImgBtn;
    }
    return _addImgBtn;
}
@end
