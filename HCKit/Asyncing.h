//
//  Asyncing.h
//
//  Created by Chenny Shan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Asyncing <NSObject>

@required
- (void)start;
- (void)cancel;

@optional
- (BOOL)inProgress;

@end

@protocol Tasking <NSObject>

@required
- (id)execute:(NSError **)error;

@end


@class HCBasicAsyncer;

@protocol AsyncDelegate <NSObject>

@optional
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer;
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result;
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error;

@end
