//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Amarpreet Singh on 08/07/12.
//  Copyright (c) 2012 Wipro Technologies. All rights reserved.
//

#import "CalculatorBrain.h"


@interface CalculatorBrain ()

@property (nonatomic) NSMutableArray * programStack ; 

@end 


@implementation CalculatorBrain

@synthesize programStack = _programStack ; 

- (NSMutableArray *)programStack 
{
    if (!_programStack) _programStack = [[NSMutableArray alloc] init]; 
    return _programStack ;
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in Homework #2";
}

- (void)pushOperand:(double)operand 
{
    // using the NSNumber as a wraper for double so we use the result in "object" to store in an NSArray
    NSNumber * operandObject = [NSNumber numberWithDouble:operand]; 
    [self.programStack addObject:operandObject]; 
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack 
{
    double result = 0 ; 
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) 
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack] ;
        else if ([operation isEqualToString:@"*"]) 
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack ] ; 
        else if ([operation isEqualToString:@"sin"])
            result = sin([self popOperandOffProgramStack:stack]); 
        else if ([operation isEqualToString:@"cos"])   
            result = cos([self popOperandOffProgramStack:stack]);
        else if ([operation isEqualToString:@"π"])     
            result = M_PI ;
        else if ([operation isEqualToString:@"sqrt"])
            result = sqrt([self popOperandOffProgramStack:stack]) ;
        else if ( [operation isEqualToString:@"-"])    
        {
            double digit = [self popOperandOffProgramStack:stack] ; 
            result = [self popOperandOffProgramStack:stack] - digit ;
        }
        else if ([operation isEqualToString:@"/"])     
        {
            double divisor = [self popOperandOffProgramStack:stack] ; 
            if(divisor) result = [self popOperandOffProgramStack:stack] / divisor ; 
        }else if ([operation isEqualToString:@"+/-"])
        {   
            result = [self popOperandOffProgramStack:stack] * - 1 ;
        }
    }
    return result ;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }    return [self popOperandOffProgramStack:stack];
}


- (double)performOperation:(NSString *)operation 
{
    [self.programStack addObject:operation]; 
    return [[self class] runProgram:self.program];
}


- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@" , self.programStack]; 
}

- (void)clearStack 
{
    [self.programStack removeAllObjects]; 
    //refreshes the stack
}
@end
