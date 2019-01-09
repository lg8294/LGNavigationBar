//
//  LGNavigationBar.m
//  LGNavigationBar
//
//  Created by Arrcen-LG on 2018/11/28.
//  Copyright © 2018 Arrcen-LG. All rights reserved.
//

#import "LGNavigationBar.h"

@interface LGNavigationBar ()

@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIImageView *backgroundImageView;

@property (nonatomic) UIImageView *shadowView;

@property (nonatomic) UIView *contentView;
@property (nonatomic) UILabel *titleLable;
@property (nonatomic) UIButton *rightBtn;
@property (nonatomic) UIButton *leftBtn;

@property (nonatomic) UIColor *barTinColor;

@end

@implementation LGNavigationBar

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (CGRectEqualToRect(frame, CGRectZero)) {
        CGFloat statusBarHeight = [self.class statusBarHeight];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self = [super initWithFrame:CGRectMake(0, statusBarHeight, width, 44)];
    } else {
        self = [super initWithFrame:frame];
    }
    if (self) {
        [self setup];
    }
    return self;
}
- (void)layoutSubviews {
    CGFloat width = self.bounds.size.width;
    if (self.barPosition == UIBarPositionTopAttached) {
        CGFloat statusBarHeight = [self.class statusBarHeight];
        [self.backgroundView setFrame:CGRectMake(0, -statusBarHeight, width, statusBarHeight+44)];
    } else {
        [self.backgroundView setFrame:CGRectMake(0, 0, width, 44)];
    }
    [self.shadowView setFrame:CGRectMake(0, 43, width, 1)];
    [self.contentView setFrame:self.bounds];
    
    [self.titleLable sizeToFit];
    [self.titleLable setCenter:CGPointMake(width/2, 22)];
    
    [self.rightBtn sizeToFit];
    CGFloat rightBtnWidth = self.rightBtn.bounds.size.width;
    rightBtnWidth = rightBtnWidth < 44 ? 44 : rightBtnWidth;
    [self.rightBtn setBounds:CGRectMake(0, 0, rightBtnWidth, 44)];
    [self.rightBtn setCenter:CGPointMake(width-rightBtnWidth/2, 22)];
    
    [self.leftBtn sizeToFit];
    CGFloat leftBtnWidth = self.leftBtn.bounds.size.width;
    leftBtnWidth = leftBtnWidth < 44 ? 44 : leftBtnWidth;
    [self.leftBtn setBounds:CGRectMake(0, 0, leftBtnWidth, 44)];
    [self.leftBtn setCenter:CGPointMake(leftBtnWidth/2, 22)];
}

#pragma mark - setup
- (void)setup {
    self.barPosition = UIBarPositionTopAttached;
    
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
    
    self.shadowView = [[UIImageView alloc] init];
    [self.shadowView setClipsToBounds:YES];
    [self.shadowView setImage:[self defautShadowImage]];
    [self addSubview:self.shadowView];
    
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.titleLable];
    [self setTitleFont:[UIFont systemFontOfSize:21 weight:UIFontWeightMedium]];
    [self setTitleColor:[UIColor blackColor]];
    
    [self.contentView addSubview:self.rightBtn];
    [self.contentView addSubview:self.leftBtn];
    
    self.barTinColor = [UIColor whiteColor];
}
- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    [self.leftBtn setTintColor:tintColor];
    [self.rightBtn setTintColor:tintColor];
}
#pragma mark - get/set
- (void)setBarPosition:(UIBarPosition)barPosition {
    _barPosition = barPosition;
    [self setNeedsLayout];
}
- (void)setBarTinColor:(UIColor *)barTinColor {
    _barTinColor = barTinColor;
    [self.backgroundView setBackgroundColor:barTinColor];
}
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
    }
    return _titleLable;
}
- (void)setTitle:(NSString *)title {
    _title = [title copy];
    [self.titleLable setText:_title];
    [self setNeedsLayout];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    [self.titleLable setFont:_titleFont];
    [self setNeedsLayout];
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.titleLable setTextColor:_titleColor];
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _rightBtn;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _leftBtn;
}
#pragma mark - public
+ (instancetype)defaultBar {
    return [[self alloc] init];
}

- (void)setBackgroundImage:(UIImage *)image {
    if (image) {
        if (self.backgroundImageView) {
            [self.backgroundImageView setImage:image];
        } else {
            self.backgroundImageView = [[UIImageView alloc] initWithImage:image];
            [self insertSubview:self.backgroundImageView belowSubview:self.shadowView];
            [self.backgroundView removeFromSuperview];
        }
    } else {
        [self insertSubview:self.backgroundView belowSubview:self.shadowView];
        if (self.backgroundImageView) {
            [self.backgroundImageView removeFromSuperview];
        }
    }
}
- (void)setBarAlpha:(CGFloat)alpha {
    if (self.backgroundImageView) {
        [self.backgroundImageView setAlpha:alpha];
    }
    self.barTinColor = [self.barTinColor colorWithAlphaComponent:alpha];
}

- (CGSize)preferredBackgroundImageSize {
    if (self.barPosition == UIBarPositionTopAttached) {
        CGFloat statusHeigh = [self.class statusBarHeight];
        return CGSizeMake(self.bounds.size.width, self.bounds.size.height+statusHeigh);
    } else {
        return self.bounds.size;
    }
}

- (void)setBottomLineHidden:(BOOL)hidden {
    self.shadowView.hidden = hidden;
}
#pragma mark - common
+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}
+ (CGFloat)navigationBarHeight {
    UINavigationBar *navigationBar = [[UINavigationBar alloc] init];
    return navigationBar.bounds.size.height;
}
- (UIImage *)defautShadowImage {
    UIImage *image;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    [line setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    UIGraphicsBeginImageContextWithOptions(line.bounds.size, NO, [UIScreen mainScreen].scale);
    [line.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
