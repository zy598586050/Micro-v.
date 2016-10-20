//
//  CustomAnimation.h
//  CABasicAnimation
//
//  Created by 王斌 on 16/1/6.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomAnimation : NSObject


//缩放
+ (CABasicAnimation *)animationScaleWithOrigin:(float)orginMultiple Multiple:(float)multiple duration:(float)duration RepeatTimes:(float)repeatTimes;

//永久闪烁的动画
+ (CABasicAnimation *)animationOpacityForeverWithDuration:(float)duration;

//有闪烁次数的动画
+ (CABasicAnimation *)animationOpacityTimesWithRepeatTimes:(float)repeatTimes duration:(float)duration;

//横向移动
+ (CABasicAnimation *)animationMoveXWithDuration:(float)duration X:(float)x;

//纵向移动
+ (CABasicAnimation *)animationMoveYWithDuration:(float)duration Y:(float)y;


//点移动
+ (CABasicAnimation *)animationMovePoint:(CGPoint)point duration:(float)duration;

//组合动画
+ (CAAnimationGroup *)animationGroupWithAnimationArray:(NSArray *)array duration:(float)duration repeatTimes:(float)repeatTimes;

//平面旋转
+ (CABasicAnimation *)animationRotationWithDegree:(float)degree duration:(float)duration direction:(int)direction repeatCount:(float)repeatCount;

//keyFrame :
//路径动画
+ (CAKeyframeAnimation *)animationKeyframeWithPath:(CGMutablePathRef)path duration:(float)duration repeatTimes:(float)repeatTimes;




@end
