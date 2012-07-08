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

- (IBAction)backpressed 
{
    
    NSUInteger lengthOfStringInDisplay  = [self.display.text  length];
    if (lengthOfStringInDisplay > 0) {
        NSRange rangeOfStringToDelete ; 
        rangeOfStringToDelete.location = lengthOfStringInDisplay - 1 ; 
        rangeOfStringToDelete.length = 1 ; 
        NSMutableString * newDisplay = [self.display.text mutableCopy];
        [newDisplay deleteCharactersInRange:rangeOfStringToDelete]; 
        NSUInteger lengthOfNewDisplay = [newDisplay length] ; 
        if (lengthOfNewDisplay == 0) {
            self.display.text = @"0" ;
            self.userIsInMiddleOfEntringNumber = NO;
        }else {
            self.display.text = newDisplay ; 
        }
    }
}

- (void)updateSentToBrainLabelwith:(NSString *)aString 
{
    
    NSRange  rangeOfEquals = [self.sentToBrain.text rangeOfString:@" = "] ;
    if ( rangeOfEquals.location != NSNotFound )
    {
        NSUInteger lengthOfStringInDisplay  = [self.sentToBrain.text  length];
        NSRange rangeOfStringToDelete ; 
        rangeOfStringToDelete.location = lengthOfStringInDisplay - 3 ; 
        rangeOfStringToDelete.length = 3 ; 
        NSMutableString * newDisplay = [self.sentToBrain.text mutableCopy];
        [newDisplay deleteCharactersInRange:rangeOfStringToDelete]; 
        self.sentToBrain.text = newDisplay ;
        
    }
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
    {
        NSRange  rangeOfDecimal = [self.display.text rangeOfString:@"."] ;
        if ( rangeOfDecimal.location == NSNotFound )
        {
        self.display.text = [self.display.text stringByAppendingString:@"."] ;
        }
    }
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
    [self updateSentToBrainLabelwith:@"="];
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
