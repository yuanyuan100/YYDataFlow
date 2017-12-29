//
//  YYObserverAgent.h
//  YYDataFlow
//
//  Created by GWWL on 2017/12/29.
//

#import <Foundation/Foundation.h>

@class YYObserveredAgent;

@interface YYObserverAgent : NSObject
@property (class, nonatomic, readonly) YYObserverAgent *manager;
@property (nonatomic, strong, readonly) NSMutableSet<YYObserveredAgent *> *observeredAgentSet;
@end
