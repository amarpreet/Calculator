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

- (void)pushVariable:(NSString *) variable 
{
    [self.programStack addObject:variable];   
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

+ (NSSet *)variablesUsedInProgram:(id)program { 
    
    // Ensure program is an NSArray
    if (![program isKindOfClass:[NSArray class]]) return nil;
    
    NSMutableSet *variablesUsed = [NSMutableSet set];
    
    // For each item in the program
    for (id programObject in program) {
        // If we think it's a variable add it to the variables set
        if ([programObject isKindOfClass:[NSString class]] && ![self isOperation:programObject]) {
            [variablesUsed addObject:programObject];    
        }
    }  
    // Return nil if we don't use any variables
    if ([variablesUsed count] == 0) 
        return nil; 
    else 
        return [variablesUsed copy];
}

+ (BOOL)isOperation:(NSString *)operation {
    // Create a set of operations used
    NSSet *setOfOperations = [NSSet setWithObjects: @"+", @"-", @"*", @"/", @"sin", 
                           @"cos", @"sqrt", @"π", @"+/-", nil];
    
    return [setOfOperations containsObject:operation];
}


+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues 
{
    if ([program isKindOfClass:[NSArray class]])
    {
        NSMutableArray *  stack = [program mutableCopy]; 
        for (NSUInteger i = 0 ; i < [stack count] ; i++) 
        {   
            // loop through all the objects
            id programObject = [stack objectAtIndex:i]; 
            // check if the object we have is variable
            if ( [programObject isKindOfClass:[NSString class]]  &&  (![self isOperation:programObject]) )
            {
                id value = [variableValues objectForKey:programObject]; 
                if (![value isKindOfClass:[NSNumber class]]) 
                {
                    // set the value to 0 if value is not a NSNumber 
                    value = 0 ;  
                }
                [stack replaceObjectAtIndex:i withObject:value]; 
            }   
        }
        return  [self popOperandOffProgramStack:stack] ;
    }
    else 
    {
        return  0 ;
    }
}

+ (double)runProgram:(id)program
{
    return [self runProgram:program usingVariableValues:nil];
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
