//
//  NSObject+YYDataFlow.m
//  YYDataFlow
//
//  Created by GitHub:yuanyuan100 on 2017/12/29.
//

#import "NSObject+YYDataFlow.h"

#import "YYObserverAgent.h"
#import "YYSameKeyPath.h"

#import <objc/runtime.h>

static void *kYYDataFlowyyKeyPathSet = &kYYDataFlowyyKeyPathSet;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject ()
/* 存放不同keypath */
@property (nonatomic, strong) NSMutableSet<YYSameKeyPath *> *yyKeyPathSet;
@end

@implementation NSObject (YYDataFlow)


#pragma mark - 核心方法
- (void)yyObserveredKeyPath:(NSString *)keyPath changed:(nonnull YYDataFlowChanged)changed {
    // 此处处理不同的keyPath
    // 匹配性能优化
    YYSameKeyPath *same = [self.yyKeyPathSet member:(YYSameKeyPath *)keyPath];
    if (same) {
        [self yyObserveredSameKeyPathOobject:same changed:changed];
        return;
    }
    
//   // 此处处理不同的keyPath
//    for (YYSameKeyPath *same in self.yyKeyPathSet) {
//        if ([same.keyPath isEqualToString:keyPath]) {
//            [self yyObserveredSameKeyPathOobject:same changed:changed];
//            return;
//        }
//    }
    
    // 新增
    YYSameKeyPath *skp = [YYSameKeyPath new];
    skp.keyPath = keyPath;
    skp.master = self;
    [self.yyKeyPathSet addObject:skp];
    [self yyObserveredSameKeyPathOobject:skp changed:changed];
}

// 分发给相同的 KeyPath 处理
- (void)yyObserveredSameKeyPathOobject:(YYSameKeyPath *)object changed:(nonnull YYDataFlowChanged)changed {
    // if 已经在观察列表中，则不需要重复观察，仅多一个回调即可
    // 但是需要记录 观察个数，在主动移除中，当同一个对象的观察个数为0则移除观察。
    [object.callBlockArray addObject:changed];
    if (object.count > 0) {
        // 不需要继续添加观察
        object.count++;
    } else {
        object.count = 1;
        [self addObserver:YYObserverAgent.manager forKeyPath:object.keyPath options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)yyRemoveObserveredKeyPath:(NSString *)keyPath changed:(nonnull YYDataFlowChanged)changed {
    
    // 此处处理不同的keyPath
    // 匹配性能优化
    YYSameKeyPath *same = [self.yyKeyPathSet member:(YYSameKeyPath *)keyPath];
    if (same) {
        [self yyRemoveObserveredSameKeyPathObject:same changed:changed];
    }
    
//    for (YYSameKeyPath *same in self.yyKeyPathSet) {
//        if ([same.keyPath isEqualToString:keyPath]) {
//            [self yyRemoveObserveredSameKeyPathObject:same changed:changed];
//        }
//    }
}

- (void)yyRemoveObserveredSameKeyPathObject:(YYSameKeyPath *)object changed:(nonnull YYDataFlowChanged)changed {
    if (object.count > 0) {
        object.count--;
        [object.callBlockArray removeObject:changed];
        if (object.count == 0) {
            // 需要移除
            [self yyRemoveOperationObserveredKeyPath:object.keyPath];
        }
    } else {
        // 需要移除
        [self yyRemoveOperationObserveredKeyPath:object.keyPath];
    }
}

- (void)yyRemoveOperationObserveredKeyPath:(NSString *)keyPath {
    [self removeObserver:YYObserverAgent.manager forKeyPath:keyPath];
}

#pragma mark - 扩展方法
- (void)yyObserveredKeyPath:(NSString *)keyPath
              bindingObject:(NSObject *)bindingObject
             bindingKeyPath:(NSString *)bindingKeyPath {
    
    
    
    __weak typeof(bindingObject) weakBindingObject = bindingObject;
    [self yyObserveredKeyPath:keyPath changed:^(id  _Nonnull newData, id  _Nonnull oldData) {
        [weakBindingObject setValue:newData forKey:bindingKeyPath];
    }];
}

#pragma mark - getter or setter
- (NSMutableSet<YYSameKeyPath *> *)yyKeyPathSet {
    id set = objc_getAssociatedObject(self, kYYDataFlowyyKeyPathSet);
    if (set == nil) {
        set = [[NSMutableSet alloc] init];
        self.yyKeyPathSet = set;
    }
    return set;
}

- (void)setYyKeyPathSet:(NSMutableSet<YYSameKeyPath *> *)yyKeyPathSet {
    objc_setAssociatedObject(self, kYYDataFlowyyKeyPathSet, yyKeyPathSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

NS_ASSUME_NONNULL_END

