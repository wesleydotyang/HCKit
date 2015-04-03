//
//  PAPathView.h
//
//  Created by Wesley Yang on 4/1/14.
//  Copyright (c) 2014 Ma. All rights reserved.
//

/**
 *  有CAShapeLayer层的view，可以画简单图形。
 *  目前用于蓝牙动画
 */

#import <UIKit/UIKit.h>

@interface PAPathView : UIView
/**
 *  shape layer
 */
@property (nonatomic,strong) CAShapeLayer *pathLayer;

/**
 *  background shape layer
 */
@property (nonatomic,strong) CAShapeLayer *bgPathLayer;

/**
 *  画path的动画(pathLayer strokeStart/strokeEnd)
 *
 *  @param duration 持续时间
 *  @param repeat   是否重复
 */
-(void)animateDrawPathAndClosePathWithDuration:(float)duration repeat:(BOOL)repeat;
-(void)animateDrawPathWithDuration:(float)duration repeat:(BOOL)repeat;

/**
 *  变色动画（pathLayer.strokeColor）
 *
 *  @param fromColor        起始颜色
 *  @param toColor          终止颜色
 *  @param duration        动画时间
 *  @param delay            延迟
 *  @param repeat          是否重复
 *  @param repeatDuration  超出duration的部分作为间隔时间
 */
-(void)animateChangeStrokeColorFromColor:(UIColor*)fromColor to:(UIColor*)toColor WithDuration:(float)duration delay:(float)delay repeat:(BOOL)repeat repeatDuration:(float)repeatDuration;


/**
 *  zoom动画（pathLayer.transform）
 *
 *  @param fromScale      起始比例
 *  @param toScale        终止比例
 *  @param center         中心点
 *  @param duration       持续时间
 *  @param repeat         是否重复
 *  @param repeatDuration 超出duration的部分作为间隔时间
 */
-(void)animateZoomFromScale:(float)fromScale to:(float)toScale zoomCenter:(CGPoint)center duration:(float)duration  repeat:(BOOL)repeat repeatDuration:(float)repeatDuration;

/**
 *  zoom path动画(pathLayer.path.transform)
 *
 *  @param fromScale        起始scale
 *  @param toScale          终止scale
 *  @param center           中心点
 *  @param duration         持续时间
 *  @param delay            延迟
 *  @param repeat           是否重复
 *  @param repeatDuration   超出duration的部分作为间隔时间
 */
-(void)animateZoomPathFromScale:(float)fromScale to:(float)toScale zoomCenter:(CGPoint)center duration:(float)duration delay:(float)delay repeat:(BOOL)repeat repeatDuration:(float)repeatDuration;

@end



/*
 
 
 UIBezierPath *btPath = [UIBezierPath bezierPath];
 [btPath moveToPoint:CGPointMake(22.524,21.73)];
 [btPath addLineToPoint:CGPointMake(73.379,69.663)];
 [btPath addLineToPoint:CGPointMake(51.636,92.593)];
 [btPath addLineToPoint:CGPointMake(51.33,10.592)];
 [btPath addLineToPoint:CGPointMake(73.954,31.874)];
 [btPath addLineToPoint:CGPointMake(24.892,79.546)];
 
 self.pathView.pathLayer.path = btPath.CGPath;
 self.pathView.pathLayer.strokeColor = UIColorFromRGB(0xf2e340).CGColor;
 
 CGPathRef btBgPath = CGPathCreateCopy(btPath.CGPath);
 self.pathView.bgPathLayer.path = btBgPath;
 CGPathRelease(btBgPath);
 self.pathView.bgPathLayer.strokeColor = UIColorFromRGB(0x6c6e6d).CGColor;
 
 self.pathView.backgroundColor = UIColorFromRGB(0x2b2c38);

 ============
 
 
 [self.pathView animateDrawPathAndClosePathWithDuration:3 repeat:YES];

 
 */

