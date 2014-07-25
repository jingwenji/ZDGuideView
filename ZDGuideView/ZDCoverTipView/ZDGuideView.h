//
//  ZDGuideView.h
//  DrawLine
//
//  Created by zhuchao on 14-7-24.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZDRevealType) {
    ZDRevealTypeRect,//矩形
    ZDRevealTypeOval//椭圆
};

@interface ZDGuideView : UIView






//下面这两个值用来调节圈圈的长宽尺寸,使它达到想要的包裹范围
///x轴外扩的值
@property(nonatomic,assign) CGFloat insetX;

///Y轴外扩的值
@property(nonatomic,assign) CGFloat insetY;


///aColor背景色,aView漏出来的view,aType露出的类型,
- (instancetype)initWithBgColor:(UIColor *)aColor revealView:(UIView *)aView revealType:(ZDRevealType)aType;

///带模糊背景的初始化
- (instancetype)initWithBlurRadius:(CGFloat)aFloat revealView:(UIView *)aView revealType:(ZDRevealType)aType;

///显示
- (void)showInView:(UIView *)aView;

///当前revealView Frame
- (CGRect)currentRevealFrame;

@end
