//
//  PALinkButton.m
//  PAQZZ
//
//  Created by Lex on 9/3/13.
//  Copyright (c) 2013 平安付. All rights reserved.
//

#import "PALinkButton.h"
#import "HCKit.h"
#define kLinkButtonTextColor UIColorFromRGB(0x2581c2)

@implementation PALinkButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
//    [self.titleLabel setTextColor:[UIColor whiteColor]];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setTitleColor:kLinkButtonTextColor forState:UIControlStateNormal];
}

/*
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, [kLinkColor CGColor]);
    CGContextMoveToPoint(context, self.titleLabel.left, self.titleLabel.bottom);
    CGContextAddLineToPoint(context, self.titleLabel.left + [self.titleLabel textRectForBounds:self.titleLabel.bounds limitedToNumberOfLines:1].size.width, self.titleLabel.bottom);
    CGContextStrokePath(context);
}
*/
@end
