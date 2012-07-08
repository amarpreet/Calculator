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
    //code of calcuation of operations or simply returning the top operand from stack
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



/*    if ([operation isEqualToString:@"+"]) 
        result = [self popOperand] + [self popOperand] ;
    else if ([operation isEqualToString:@"*"]) 
        result = [self popOperand] * [self popOperand ] ; 
    else if ([operation isEqualToString:@"sin"])
        result = sin([self popOperand]); 
    else if ([operation isEqualToString:@"cos"])   
        result = cos([self popOperand]);
    else if ([operation isEqualToString:@"π"])     
        result = M_PI ;
    else if ([operation isEqualToString:@"sqrt"])
        result = sqrt([self popOperand]) ;
    else if ( [operation isEqualToString:@"-"])    
    {
        double digit = [self popOperand] ; 
        result = [self popOperand] - digit ;
    }
    else if ([operation isEqualToString:@"/"])     
    {
        double divisor = [self popOperand] ; 
        if(divisor) result = [self popOperand] / divisor ; 
    }else if ([operation isEqualToString:@"+/-"])
    {   
        result = [self popOperand] * - 1 ;
    }
    */


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
