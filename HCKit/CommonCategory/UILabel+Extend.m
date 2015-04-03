//
//  UILabel+Extend.m
//  PAQZZ
//
//  Created by Chenny Shan on 5/26/14.
//  Copyright (c) 2014 平安付. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel (Extend)

- (void)sizeToFitFixedWidth:(CGFloat)width
{
//    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    [self sizeToFit];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, CGRectGetHeight(self.frame));
}


/**
 *  Borrow from http://stackoverflow.com/questions/10193073/ios-determine-last-line-width-of-uilabel
 */
- (NSArray *)separatedLines
{
    if (self.lineBreakMode != NSLineBreakByWordWrapping) {
        return nil;
    }
    
    NSMutableArray* lines = [NSMutableArray arrayWithCapacity:10];
    NSCharacterSet* wordSeparators = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString* currentLine = self.text;
    NSInteger textLength = [self.text length];
    NSRange rCurrentLine = NSMakeRange(0, textLength);
    NSRange rWhitespace = NSMakeRange(0, 0);
    NSRange rRemainingText = NSMakeRange(0, textLength);
    BOOL done = NO;
    while (!done) {
        rWhitespace.location = rWhitespace.location + rWhitespace.length;
        rWhitespace.length = textLength - rWhitespace.location;
        rWhitespace = [self.text rangeOfCharacterFromSet: wordSeparators options: NSCaseInsensitiveSearch range: rWhitespace];
        if (rWhitespace.location == NSNotFound) {
            rWhitespace.location = textLength;
            done = YES;
        }
        NSRange rTest = NSMakeRange(rRemainingText.location, rWhitespace.location - rRemainingText.location);
        NSString* textTest = [self.text substringWithRange:rTest];
        CGSize sizeTest = [textTest sizeWithFont:self.font forWidth: 1024.0 lineBreakMode:NSLineBreakByWordWrapping];
        if (sizeTest.width > self.bounds.size.width) {
            [lines addObject: [currentLine stringByTrimmingCharactersInSet:wordSeparators]];
            rRemainingText.location = rCurrentLine.location + rCurrentLine.length;
            rRemainingText.length = textLength-rRemainingText.location;
            continue;
        }
        rCurrentLine = rTest;
        currentLine = textTest;
    }
    [lines addObject: [currentLine stringByTrimmingCharactersInSet:wordSeparators]];
    return lines;
}

@end
