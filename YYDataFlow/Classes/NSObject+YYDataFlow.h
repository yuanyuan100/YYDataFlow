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

/**
 观察当前对象的keyPath的值
 @default 自动移除
 @param keyPath 被观察者的属性路径
 @param changed YYDataFlowChanged
 */
- (void)yyObserveredKeyPath:(NSString *)keyPath changed:(YYDataFlowChanged)changed;

/**
 主动移除 观察当前对象的keyPath的值

 @param keyPath 被观察者的属性路径
 @param changed YYDataFlowChanged
 */
- (void)yyRemoveObserveredKeyPath:(NSString *)keyPath changed:(YYDataFlowChanged)changed;

@end

@interface NSObject (YYPassiveObject)

/**
 数据驱动 当前对象的keyPath的值改变
 
 @warming 约定 keyPath 与 bindingKeyPath 属性类型相同
 @default 自动移除
 @param passvieKeyPath 当前对象的属性路径
 @param adjectiveObject 数据对象
 @param adjectiveKeyPath 数据对象的属性路径
 */
- (void)yyPassiveKeyPath:(NSString *)passvieKeyPath adjectiveObject:(NSObject *)adjectiveObject adjectiveKeyPath:(NSString *)adjectiveKeyPath;

/**
 数据驱动 当前对象的keyPath的值改变
 
 @default 自动移除
 @param passvieKeyPath 当前对象的属性路径
 @param adjectiveObject 数据对象
 @param adjectiveKeyPath 数据对象的属性路径
 @param isString if YES ,将数据对象adjectiveKeyPath路径上的属性类型转为NSString赋值给当前对象passvieKeyPath路径上的属性
 */
- (void)yyPassiveKeyPath:(NSString *)passvieKeyPath adjectiveObject:(NSObject *)adjectiveObject adjectiveKeyPath:(NSString *)adjectiveKeyPath transformToString:(BOOL)isString;
@end

NS_ASSUME_NONNULL_END
