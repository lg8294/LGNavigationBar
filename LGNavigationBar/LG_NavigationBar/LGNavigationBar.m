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
@property (nonatomic) UIButton *rightButton;
@property (nonatomic) UIButton *leftButton;

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
}

#pragma mark - setup
- (void)setup {
    self.barPosition = UIBarPositionTopAttached;
    
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
    
    self.shadowView = [[UIImageView alloc] init];
    [self.shadowView setClipsToBounds:YES];
    [self addSubview:self.shadowView];
    
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.titleLable];
    [self setTitleFont:[UIFont systemFontOfSize:21 weight:UIFontWeightMedium]];
    [self setTitleColor:[UIColor blackColor]];
    
    self.barTinColor = [UIColor whiteColor];
}
#pragma mark - get/set
- (void)setBarPosition:(UIBarPosition)barPosition {
    _barPosition = barPosition;
    [self setNeedsLayout];
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
#pragma mark - public
+ (instancetype)defaultBar {
    return [[self alloc] init];
}
- (void)setBarTinColor:(UIColor *)barTinColor {
    _barTinColor = barTinColor;
    [self.backgroundView setBackgroundColor:barTinColor];
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
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bounds.size.width, 1) , NO, [UIScreen mainScreen].scale);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
