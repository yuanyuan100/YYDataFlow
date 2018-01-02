//
//  YYSameKeyPath.h
//  YYDataFlow
//
//  Created by GitHub:yuanyuan100 on 2017/12/30.
//

#import <Foundation/Foundation.h>

@interface YYSameKeyPath : NSObject
/* 持有自己的对象 */
@property (nonatomic, weak) NSObject *master;
/* 属性 */
@property (nonatomic, copy) NSString *keyPath;
/* 计数 */
@property (nonatomic, assign) NSInteger count;
/* 存储回调 */
@property (nonatomic, strong, readonly) NSMutableArray *callBlockArray;
@end
