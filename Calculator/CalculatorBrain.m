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


- (double)popOperand 
{
    NSNumber * operandObject = [self.operandStack lastObject] ; 
    if (operandObject) [self.operandStack removeLastObject]; 
    
    return [operandObject doubleValue]; 
}


- (double)performOperation:(NSString *)operation 
{
    double result = 0; 
    if ([operation isEqualToString:@"+"]) 
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
    
    [self pushOperand:result]; // push the operand back on to the stack 
    return  result ; 
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@" , self.operandStack]; 
}

- (void)clearStack 
{
    [self.operandStack removeAllObjects]; 
    //refreshes the stack
}
@end
