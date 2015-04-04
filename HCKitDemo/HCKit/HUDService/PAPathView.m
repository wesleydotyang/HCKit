//
//  PAPathView.m
//
//  Created by Wesley Yang on 4/1/14.
//  Copyright (c) 2014 Ma. All rights reserved.
//

#import "PAPathView.h"

@interface PAPathView()

@end

@implementation PAPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup_];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup_];
    }
    return self;
}


-(void)setup_
{
    self.bgPathLayer = [[CAShapeLayer alloc] init];
    self.bgPathLayer.frame = self.bounds;
    self.bgPathLayer.fillColor = [UIColor clearColor].CGColor;
    self.bgPathLayer.strokeColor = [UIColor grayColor].CGColor;
    self.bgPathLayer.lineWidth = 5;
    [self.layer addSublayer:self.bgPathLayer];
    
    self.pathLayer = [[CAShapeLayer alloc] init];
    self.pathLayer.frame = self.bounds;
    self.pathLayer.fillColor = [UIColor clearColor].CGColor;
    self.pathLayer.strokeColor = [UIColor blackColor].CGColor;
    self.pathLayer.lineWidth = 5;
    [self.layer addSublayer:self.pathLayer];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.pathLayer.frame = self.bounds;
    self.bgPathLayer.frame = self.bounds;
}

-(void)animateDrawPathAndClosePathWithDuration:(float)duration repeat:(BOOL)repeat
{
    float repeatPercent = 0.3;//动画间隔中休息时间
    NSNumber *animatePercent = [NSNumber numberWithFloat:(1-repeatPercent)/2];
    NSNumber *animateEndPercent = [NSNumber numberWithFloat:(1-repeatPercent)];
    
    CAMediaTimingFunction *timeEaseOut = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAMediaTimingFunction *timeEaseIn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.duration = duration;
    animation1.repeatCount = repeat ? HUGE_VALF:1;
    animation1.values = @[@0.0,@1.0];
    animation1.keyTimes = @[@0.0,animatePercent];
    animation1.timingFunctions = @[timeEaseOut];
    animation1.delegate = self;
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    animation2.values = @[@0.0,@1.0];
    animation2.keyTimes = @[animatePercent,animateEndPercent];
    animation2.timingFunctions = @[timeEaseIn];
    animation2.duration = duration;
    animation2.repeatCount = repeat ? HUGE_VALF:1;
    animation2.delegate = self;
    
    [self.pathLayer addAnimation:animation1 forKey:@"patha1"];
    [self.pathLayer addAnimation:animation2 forKey:@"patha2"];
}

-(void)animateDrawPathWithDuration:(float)duration repeat:(BOOL)repeat{
    float repeatPercent = 0.0;//动画间隔中休息时间
    NSNumber *animatePercent = [NSNumber numberWithFloat:(1-repeatPercent)/2];
    CAMediaTimingFunction *timeEaseIn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.duration = duration;
    animation1.repeatCount = repeat ? HUGE_VALF:1;
    animation1.values = @[@0.0,@1.0];
    animation1.keyTimes = @[@0.0,animatePercent];
    animation1.timingFunctions = @[timeEaseIn];
    //animation1.delegate = self;
    [self.pathLayer addAnimation:animation1 forKey:@"patha1"];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]) {
        CAKeyframeAnimation *kanim = (CAKeyframeAnimation *)anim;
        if ([kanim.keyPath isEqualToString:@"strokeEnd"]) {
            
        }
        else if ([kanim.keyPath isEqualToString:@"strokeEnd"]){
            
        }
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]) {
        CAKeyframeAnimation *kanim = (CAKeyframeAnimation *)anim;
        if ([kanim.keyPath isEqualToString:@"strokeEnd"]) {
            
        }
        else if ([kanim.keyPath isEqualToString:@"strokeEnd"]){
            
        }
    }
}

-(void)animateChangeStrokeColorFromColor:(UIColor *)fromColor to:(UIColor *)toColor WithDuration:(float)duration delay:(float)delay repeat:(BOOL)repeat repeatDuration:(float)repeatDuration
{
    if (repeatDuration<duration) {
        repeatDuration = duration;
    }
    float waitingPercent = (repeatDuration-duration)/repeatDuration;
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
    animation1.duration = duration;
    animation1.repeatCount = repeat ? HUGE_VALF:1;
    animation1.values = @[(id)fromColor.CGColor,(id)toColor.CGColor];
    animation1.keyTimes = @[@0.0,[NSNumber numberWithFloat:(1-waitingPercent)]];
    animation1.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation1.beginTime = CACurrentMediaTime() + delay;
    
    [self.pathLayer addAnimation:animation1 forKey:@"pathstrokecolor"];
    
}

-(void)animateZoomFromScale:(float)fromScale to:(float)toScale zoomCenter:(CGPoint)center duration:(float)duration repeat:(BOOL)repeat repeatDuration:(float)repeatDuration
{
    CGPoint oriCenter = CGPointMake(self.pathLayer.bounds.size.width/2, self.pathLayer.bounds.size.height/2);
    
    if (repeatDuration<duration) {
        repeatDuration = duration;
    }
    float waitingPercent = (repeatDuration-duration)/repeatDuration;
    
    CATransform3D trans = self.pathLayer.transform;
    CATransform3D fromTrans;
    fromTrans = CATransform3DTranslate(trans,(oriCenter.x-center.x)*(fromScale-1) , (oriCenter.y - center.y)*(fromScale-1) , 0);
    fromTrans = CATransform3DScale(fromTrans,fromScale, fromScale, 1);
    
    CATransform3D toTrans;
    toTrans = CATransform3DTranslate(trans,(oriCenter.x-center.x)*(toScale-1) , (oriCenter.y - center.y)*(toScale-1) , 0);
    toTrans = CATransform3DScale(toTrans,toScale, toScale, 1);
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation1.duration = duration;
    animation1.repeatCount = repeat ? HUGE_VALF:1;
    animation1.values = @[[NSValue valueWithCATransform3D:fromTrans],[NSValue valueWithCATransform3D:toTrans]];
    animation1.keyTimes = @[@0.0,[NSNumber numberWithFloat:(1-waitingPercent)]];
    animation1.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    [self.pathLayer addAnimation:animation1 forKey:@"zoom"];
    
}

-(void)animateZoomPathFromScale:(float)fromScale to:(float)toScale zoomCenter:(CGPoint)center duration:(float)duration delay:(float)delay repeat:(BOOL)repeat repeatDuration:(float)repeatDuration
{
    
    if (repeatDuration<duration) {
        repeatDuration = duration;
    }
    float waitingPercent = (repeatDuration-duration)/repeatDuration;
    
    
    CGPathRef path = self.pathLayer.path;
    
    CGAffineTransform trans = CGAffineTransformIdentity;
    CGAffineTransform fromTrans = trans;
    fromTrans = CGAffineTransformTranslate(fromTrans,(-center.x)*(fromScale-1) , (- center.y)*(fromScale-1));
    fromTrans = CGAffineTransformScale(fromTrans,fromScale, fromScale);
    
    
    CGAffineTransform toTrans = trans;
    toTrans = CGAffineTransformTranslate(toTrans,(-center.x)*(toScale-1) , (- center.y)*(toScale-1));
    
    toTrans = CGAffineTransformScale(toTrans,toScale, toScale);
    
    CGPathRef fromPath = CGPathCreateMutableCopyByTransformingPath(path, &fromTrans);
    CGPathRef toPath = CGPathCreateMutableCopyByTransformingPath(path, &toTrans);
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    
    animation2.duration = duration;
    animation2.repeatCount = repeat ? HUGE_VALF:1;
    animation2.values = @[(__bridge id)fromPath,(__bridge id)toPath];
    animation2.keyTimes = @[@0.0,[NSNumber numberWithFloat:(1-waitingPercent)]];
    animation2.beginTime = CACurrentMediaTime() + delay;
    
    [self.pathLayer addAnimation:animation2 forKey:@"pathzoom"];
    
    CGPathRelease(fromPath);
    CGPathRelease(toPath);
    
}



@end
