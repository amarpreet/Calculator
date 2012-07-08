//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Amarpreet Singh on 08/07/12.
//  Copyright (c) 2012 Wipro Technologies. All rights reserved.
//

#import "CalculatorBrain.h"


@interface CalculatorBrain ()

@property (nonatomic) NSMutableArray * operandStack ; 

@end 


@implementation CalculatorBrain

@synthesize operandStack = _operandStack ; 

- (NSMutableArray *)operandStack 
{
    if (!_operandStack) _operandStack = [[NSMutableArray alloc] init]; 
    return _operandStack ;
}

- (void)pushOperand:(double)operand 
{
    // using the NSNumber as a wraper for double so we use the result in "object" to store in an NSArray
    NSNumber * operandObject = [NSNumber numberWithDouble:operand]; 
    [self.operandStack addObject:operandObject]; 
}
- (double)performOperation:(NSString *)operation 
{
    double result = 0; 
    // code to perfrom the requested operations and return the result ; 
    return  result ; 
}
@end
