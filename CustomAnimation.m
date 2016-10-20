//
//  CustomAnimation.m
//  CABasicAnimation
//
//  Created by 王斌 on 16/1/6.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import "CustomAnimation.h"

@implementation CustomAnimation

//缩放
+ (CABasicAnimation *)animationScaleWithOrigin:(float)orginMultiple Multiple:(float)multiple duration:(float)duration RepeatTimes:(float)repeatTimes{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:orginMultiple];
    animation.toValue = [NSNumber numberWithFloat:multiple];
    animation.duration = duration;
    animation.autoreverses = YES;
    animation.repeatCount = repeatTimes;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    return animation;
}

//永久闪烁的动画
+ (CABasicAnimation *)animationOpacityForeverWithDuration:(float)duration{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.autoreverses=YES;
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

//有闪烁次数的动画
+(CABasicAnimation *)animationOpacityTimesWithRepeatTimes:(float)repeatTimes duration:(float)duration{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.4];
    animation.repeatCount = repeatTimes;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = YES;
    
    return  animation;
}


//横向移动
+ (CABasicAnimation *)animationMoveXWithDuration:(float)duration X:(float)x{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = [NSNumber numberWithFloat:x];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

//纵向移动
+ (CABasicAnimation *)animationMoveYWithDuration:(float)duration Y:(float)y{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue = [NSNumber numberWithFloat:y];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}


//点移动
+ (CABasicAnimation *)animationMovePoint:(CGPoint)point duration:(float)duration{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 1;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}


//组合动画
+ (CAAnimationGroup *)animationGroupWithAnimationArray:(NSArray *)array duration:(float)duration repeatTimes:(float)repeatTimes{
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = array;
    animation.duration = duration;
    animation.repeatCount = repeatTimes;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    return animation;
}

//平面旋转
+ (CABasicAnimation *)animationRotationWithDegree:(float)degree duration:(float)duration direction:(int)direction repeatCount:(float)repeatCount{
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0, direction);
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = duration;
    animation.autoreverses = NO;
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    animation.delegate = self;
    
    return animation;
}

//keyframe
//路径动画
+ (CAKeyframeAnimation *)animationKeyframeWithPath:(CGMutablePathRef)path duration:(float)duration repeatTimes:(float)repeatTimes{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = NO;
    animation.duration = duration;
    animation.repeatCount = repeatTimes;
    
    return animation;
}









@end
