//
//  NSObject+YYDataFlow.h
//  YYDataFlow
//
//  Created by GitHub:yuanyuan100 on 2017/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 监听到数据发生改变

 @param newData 新数据
 @param oldData 旧数据
 */
typedef void(^YYDataFlowChanged)(id newData, id oldData);

@interface NSObject (YYDataFlow)

- (void)yyObserveredKeyPath:(NSString *)keyPath changed:(YYDataFlowChanged)changed;

- (void)yyRemoveObserveredKeyPath:(NSString *)keyPath changed:(YYDataFlowChanged)changed;

- (void)yyObserveredKeyPath:(NSString *)keyPath bindingObject:(NSObject *)bindingObject bindingKeyPath:(NSString *)bindingKeyPath;
- (void)yyRemoveObserveredKeyPath:(NSString *)keyPath bindingObject:(NSObject *)bindingObject bindingKeyPath:(NSString *)bindingKeyPath;

// 1.提供主动移除观察绑定
// 2.提供自动移除观察绑定

@end

NS_ASSUME_NONNULL_END
