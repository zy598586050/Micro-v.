//
//  DITopNavigationTheme.h
//  DIOpenSDK
//
//  Created by didi on 16/2/20.
//  Copyright © 2016年 com.xiaojukeji.didiOpenSdk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DITopNavLeftBtnsShowStyle)
{
    DITopNavLeftBtnsShowStyleAlwaysShowBack,
    DITopNavLeftBtnsShowStyleAlwaysShowClose
};

@interface DITopNavigationTheme : NSObject
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;                     // 状态栏内容样式
@property (nonatomic, strong) UIColor *backgroundColor;                            // 导航条背景色
@property (nonatomic, strong) UIFont *titleFont;                                   // 导航条标题font
@property (nonatomic, strong) UIColor *titleTextColor;                             // 导航条标题颜色
@property (nonatomic, assign) DITopNavLeftBtnsShowStyle leftBtnsShowStyle;         // 导航条左边按钮展示样式

@property (nonatomic, assign) CGFloat backBtnLeftMargin;                           // 导航条左边按钮左边距
@property (nonatomic, strong) UIImage *backNormalImage;                            // 导航条返回按钮图片
@property (nonatomic, strong) UIImage *backHighlightImage;

@property (nonatomic, assign) CGFloat leftBtnsSpace;                               // 左边按钮间距
@property (nonatomic, strong) UIImage *closeNormalImage;                           // 导航条关闭按钮图片
@property (nonatomic, strong) UIImage *closeHighlightImage;
@end
