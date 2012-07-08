//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Amarpreet Singh on 08/07/12.
//  Copyright (c) 2012 Wipro Technologies. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInMiddleOfEntringNumber ; 

@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInMiddleOfEntringNumber = _userIsInMiddleOfEntringNumber ;


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


- (void)viewDidUnload 
{
    [self setDisplay:nil];
    [super viewDidUnload];
}
@end
