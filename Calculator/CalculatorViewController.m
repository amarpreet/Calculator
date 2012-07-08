//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Amarpreet Singh on 08/07/12.
//  Copyright (c) 2012 Wipro Technologies. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInMiddleOfEntringNumber ;
@property (nonatomic, strong ) CalculatorBrain * brain ; 

@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInMiddleOfEntringNumber = _userIsInMiddleOfEntringNumber ;
@synthesize brain = _brain ; 

- (CalculatorBrain *)brain 
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init]; 
    
    return _brain ; 
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    if (self.userIsInMiddleOfEntringNumber) 
    {
        self.display.text = [self.display.text stringByAppendingString:sender.currentTitle]; 
    }
    else 
    {
        self.display.text = sender.currentTitle ; 
        self.userIsInMiddleOfEntringNumber = YES ;
    }
    NSLog(@"user touched %@" , sender.currentTitle);
    
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]]; 
    self.userIsInMiddleOfEntringNumber = NO ; 
    NSLog(@"user touched enter on %g",[self.display.text doubleValue]); 
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInMiddleOfEntringNumber) {
        [self enterPressed];
    }
    NSString * operation = sender.currentTitle ; 
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g" , result ]; 
    NSLog(@"user touched operation %@" , sender.currentTitle);
}


- (void)viewDidUnload 
{
    [self setDisplay:nil];
    [super viewDidUnload];
}
@end
