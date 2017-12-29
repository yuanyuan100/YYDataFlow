//
//  YYViewController.m
//  YYDataFlow
//
//  Created by Yvan on 12/29/2017.
//  Copyright (c) 2017 Yvan. All rights reserved.
//

#import "YYViewController.h"
#import <YYDataFlow/NSObject+YYDataFlow.h>
#import "Person.h"

@interface YYViewController ()
@property (nonatomic, strong) Person *person;
@end

@implementation YYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    Person *person = [Person new];
    self.person = person;
    person.name = @"pyy1";
    YYDataFlowChanged a = ^(id  _Nonnull newData, id  _Nonnull oldData) {
        
    };
    [person yyObserveredKeyPath:@"name" changed:a];
    
    YYDataFlowChanged b = ^(id  _Nonnull newData, id  _Nonnull oldData) {
        
    };
    [person yyObserveredKeyPath:@"name" changed:b];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        person.name = @"pyy2";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [person yyRemoveObserveredKeyPath:@"name" changed:a];
            [person yyRemoveObserveredKeyPath:@"name" changed:b];
            
            person.name = @"pyy3";
            
            [self performSelector:@selector(personToNil) withObject:nil afterDelay:3];
            
        });
    });
    
    
}

- (void)personToNil {
    self.person = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
