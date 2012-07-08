//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Amarpreet Singh on 08/07/12.
//  Copyright (c) 2012 Wipro Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand ; 
- (double)performOperation:(NSString *)operation ;
- (void)clearStack ; 

@end
