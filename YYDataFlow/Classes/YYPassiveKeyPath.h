//
//  YYPassiveKeyPath.h
//  YYDataFlow
//
//  Created by GWWL on 2017/12/31.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYDataFlow.h"

@interface YYPassiveKeyPath : NSObject
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, weak) NSObject *adjectiveObject;
@property (nonatomic, copy) YYDataFlowChanged changed;
@property (nonatomic, copy) NSString *adjectiveKeyPath;
@end
