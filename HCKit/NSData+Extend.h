//
//  NSData+Extend.h
//  PAMobileWallet
//
//  Created by Pay_SMP002 on 13-7-17.
//  Copyright (c) 2013年 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)
+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;
@end
