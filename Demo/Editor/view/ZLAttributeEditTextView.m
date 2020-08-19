//
//  ZLAttributeEditTextView.m
//  Demo
//
//  Created by Yuki on 2020/8/18.
//  Copyright © 2020 Zl. All rights reserved.
//  富文本编辑器

#import "ZLAttributeEditTextView.h"

@interface ZLAttributeEditTextView ()
/**  富文本样式  **/
@property (nonatomic , strong)NSDictionary  *typeAttributes_diy;
@end
@implementation ZLAttributeEditTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

#pragma mark - --------- 修改UI  ---------
- (void)buildUI{
    self.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.layer.borderWidth = 1;
    
    
    self.typingAttributes = self.typeAttributes_diy;
}


#pragma mark - --------- set方法  ---------
//设置图片
- (void)setImgArray:(NSMutableArray *)imgArray{
    /**  获取当前选中的位置  **/
    NSRange currentRange = NSMakeRange(self.selectedRange.location, self.selectedRange.length);
    /**  先获取到编辑器中的所有富文本  **/
    NSMutableAttributedString *oldAttri = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    /**  创建图片并插入图片  **/
    for (UIImage *img in imgArray) {
        
        NSTextAttachment *imgAttachment = [[NSTextAttachment alloc]initWithData:nil ofType:nil];
        imgAttachment.image = img;
        imgAttachment.bounds = CGRectMake(0, 0, img.size.width, img.size.height);
        
        NSAttributedString *newAttri = [NSAttributedString attributedStringWithAttachment:imgAttachment];
        /**  插入图片的位置，可以是最后，可以是当前光标的位置后面  **/
        [oldAttri insertAttributedString:newAttri atIndex:oldAttri.length];//插入到最后
//        [oldAttri insertAttributedString:newAttri atIndex:currentRange.location];
    }
    
    /**  插入换行  **/
    NSAttributedString *enterAttri = [[NSAttributedString alloc]initWithString:@" \n"];
    [oldAttri insertAttributedString:enterAttri atIndex:oldAttri.length];
//    [oldAttri insertAttributedString:enterAttri atIndex:currentRange.location + imgArray.count ];
    self.selectedRange = NSMakeRange(currentRange.location + imgArray.count, 0);
    
    /**  重新设置富文本的格式，字体大小，行间距等  **/
    [oldAttri addAttributes:self.typeAttributes_diy range:NSMakeRange(0, oldAttri.length)];
    
    /**  重新赋值  **/
    self.attributedText = oldAttri;
}


/**  富文本的默认样式  **/
- (NSDictionary *)typeAttributes_diy{
    /**  设置行间距  **/
    NSMutableParagraphStyle *ps = [NSMutableParagraphStyle new];
    ps.lineSpacing = 10;
    return @{
        NSParagraphStyleAttributeName :ps,
        NSFontAttributeName : [UIFont systemFontOfSize:17]
    };
}
@end
