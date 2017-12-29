//
//  YYObserveredAgent.h
//  YYDataFlow
//
//  Created by GWWL on 2017/12/29.
//

#import <Foundation/Foundation.h>

@interface YYObserveredAgent : NSObject
/* 真正的被观察者 */
@property (nonatomic, weak) id realObservered;
/* 计数 */
@property (nonatomic, assign) NSInteger count;
/* 存放回调 */
@property (nonatomic, strong, readonly) NSMutableArray *callBlockArray;
@end
