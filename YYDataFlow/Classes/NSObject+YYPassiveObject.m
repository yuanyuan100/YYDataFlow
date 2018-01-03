//
//  NSObject+YYPassiveObject.m
//  YYDataFlow
//
//  Created by GWWL on 2017/12/31.
//

#import "NSObject+YYPassiveObject.h"
#import <Objc/message.h>
#import "NSObject+YYDataFlow.h"

#import "YYPassiveKeyPath.h"


static void * kYYPassiveObjectyyPassiveKeyPathArray = &kYYPassiveObjectyyPassiveKeyPathArray;

@interface NSObject ()
/**
 涉及 block 回调顺序，且元素不会太多，故使用数组而不用集合

 author pyy
 */
@property (nonatomic, strong) NSMutableArray *yyPassiveKeyPathArray;
@end

@implementation NSObject (YYPassiveObject)

- (void)yyPassiveKeyPath:(NSString *)passvieKeyPath
         adjectiveObject:(NSObject *)adjectiveObject
        adjectiveKeyPath:(NSString *)adjectiveKeyPath {
    
    [self yyPassiveKeyPath:passvieKeyPath
           adjectiveObject:adjectiveObject
          adjectiveKeyPath:adjectiveKeyPath
         transformToString:NO];
    
}

- (void)yyPassiveKeyPath:(NSString *)passvieKeyPath
         adjectiveObject:(NSObject *)adjectiveObject
        adjectiveKeyPath:(NSString *)adjectiveKeyPath
       transformToString:(BOOL)isString {
    for (YYPassiveKeyPath *kp in self.yyPassiveKeyPathArray) {
        if ([kp.keyPath isEqualToString:passvieKeyPath]) {
            // 表示存在 旧的删除，创建一个新的
            [kp.adjectiveObject yyRemoveObserveredKeyPath:kp.adjectiveKeyPath changed:kp.changed];
            [self.yyPassiveKeyPathArray removeObject:kp];
            break;
        }
    }
    
    YYPassiveKeyPath *kp = [YYPassiveKeyPath new];
    kp.keyPath = passvieKeyPath;
    kp.adjectiveKeyPath = adjectiveKeyPath;
    kp.adjectiveObject = adjectiveObject;
    __weak typeof(self) weakSelf = self;
    kp.changed = ^(id  _Nonnull newData, id  _Nonnull oldData) {
        if (isString) {
           [weakSelf setValue:[NSString stringWithFormat:@"%@", newData] forKeyPath:passvieKeyPath];
        } else {
            [weakSelf setValue:newData forKeyPath:passvieKeyPath];
        }
        
    };
    [self.yyPassiveKeyPathArray addObject:kp];
    
    [adjectiveObject yyObserveredKeyPath:adjectiveKeyPath changed:kp.changed];
}

#pragma mark - getter or setter
- (NSMutableArray *)yyPassiveKeyPathArray {
    NSMutableArray *obj = objc_getAssociatedObject(self, kYYPassiveObjectyyPassiveKeyPathArray);
    if (obj == nil) {
        obj = [[NSMutableArray alloc] init];
        self.yyPassiveKeyPathArray = obj;
    }
    return obj;
}

- (void)setYyPassiveKeyPathArray:(NSMutableArray *)yyPassiveKeyPathArray {
    objc_setAssociatedObject(self, kYYPassiveObjectyyPassiveKeyPathArray, yyPassiveKeyPathArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
