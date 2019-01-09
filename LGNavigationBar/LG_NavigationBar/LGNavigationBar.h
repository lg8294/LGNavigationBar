//
//  LGNavigationBar.h
//  LGNavigationBar
//
//  Created by Arrcen-LG on 2018/11/28.
//  Copyright © 2018 Arrcen-LG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGNavigationBar : UIView

@property (nonatomic) UIBarPosition barPosition;

/**
 默认 bar 样式

 @return LGNavigationBar
 */
+ (instancetype)defaultBar;


/**
 设置 bar 颜色

 @param barTinColor bar 颜色
 */
- (void)setBarTinColor:(UIColor *)barTinColor;

/**
 设置 bar 背景图片

 @param image 背景图片
 */
- (void)setBackgroundImage:(UIImage *)image;

/**
 设置 bar 透明度

 @param alpha 透明度
 */
- (void)setBarAlpha:(CGFloat)alpha;

/**
 推荐的背景图尺寸

 @return 推荐尺寸
 */
- (CGSize)preferredBackgroundImageSize;


/**
 标题
 */
@property (nonatomic,copy) NSString *title;

/**
 标题颜色
 */
@property (nonatomic) UIColor *titleColor;

/**
 标题字体
 */
@property (nonatomic) UIFont *titleFont;

/**
 左边按键
 */
@property (nonatomic,readonly) UIButton *leftBtn;

/**
 右边按键
 */
@property (nonatomic,readonly) UIButton *rightBtn;

- (void)setBottomLineHidden:(BOOL)hidden;
@end

NS_ASSUME_NONNULL_END
