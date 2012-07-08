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
    // code to push and operand onto the stack 
}
- (double)performOperation:(NSString *)operation 
{
    double result = 0; 
    // code to perfrom the requested operations and return the result ; 
    return  result ; 
}
@end
