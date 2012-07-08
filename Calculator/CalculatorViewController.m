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
@property (weak, nonatomic) IBOutlet UILabel *sentToBrain;

@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInMiddleOfEntringNumber = _userIsInMiddleOfEntringNumber ;
@synthesize brain = _brain ; 
@synthesize sentToBrain = _sentToBrain;

- (CalculatorBrain *)brain 
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init]; 
    
    return _brain ; 
}

- (void)updateSentToBrainLabelwith:(NSString *)aString 
{
    self.sentToBrain.text = [self.sentToBrain.text stringByAppendingFormat:@" %@ " , aString];
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
- (IBAction)decimalPressed 
{
    if (self.userIsInMiddleOfEntringNumber) 
        self.display.text = [self.display.text stringByAppendingString:@"."] ;
    else 
    {
        self.display.text = [NSString stringWithFormat:@"0."] ; 
        self.userIsInMiddleOfEntringNumber = YES ;
    }

}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]]; 
    
    [self updateSentToBrainLabelwith:self.display.text]; 
    
    self.userIsInMiddleOfEntringNumber = NO ; 
    NSLog(@"user touched enter on %g",[self.display.text doubleValue]);
    NSLog(@"operand stack right now : %@" , self.brain); 
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInMiddleOfEntringNumber) {
        [self enterPressed];
    }
    NSString * operation = sender.currentTitle ; 
    [self updateSentToBrainLabelwith:operation]; 
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g" , result ]; 
    NSLog(@"user touched operation %@" , sender.currentTitle);
    NSLog(@"operand stack right now : %@" , self.brain); 

}

- (IBAction)clear 
{
    [self.brain clearStack]; 
    self.sentToBrain.text = [NSString stringWithFormat:@""];
    self.display.text = [NSString stringWithFormat:@"0"];
    NSLog(@"everything cleared"); 
}

- (void)viewDidUnload 
{
    [self setDisplay:nil];
    [self setSentToBrain:nil];
    [super viewDidUnload];
}
@end
