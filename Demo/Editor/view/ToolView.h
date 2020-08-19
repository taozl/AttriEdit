//
//  ToolView.h
//  Demo
//
//  Created by Yuki on 2020/8/18.
//  Copyright © 2020 Zl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetAttributeImageArrayBlock)(NSMutableArray<UIImage *>  *attriImgAry);//获取到图片数组
@interface ToolView : UIView
/**  获取到图片回调  **/
@property (nonatomic , copy)GetAttributeImageArrayBlock getAttributeImageArrayBlock;
@end

NS_ASSUME_NONNULL_END
