//
//  SimpleCalculatorVC.m
//  Calculator
//
//  Created by User on 12/2/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import "SimpleCalculatorVC.h"

@interface SimpleCalculatorVC ()

@property (nonatomic) Calculator *calculator;

@property (weak, nonatomic) IBOutlet UILabel *inputLabel;

@end

@implementation SimpleCalculatorVC

@synthesize calculator = _calculator;

- (Calculator *)calculator {
    if (!_calculator) {
        _calculator = [[Calculator alloc] init];
    }
    
    return _calculator;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)touchButton:(UIButton *)sender {
    NSLog(@"touchButton");
    
    NSString *character = [sender titleLabel].text;
    
    if ([character isEqualToString:@"="]) {
        [self.calculator calculate];
    
    } else if ([character isEqualToString:@"AC"]) {
        [self.calculator allClear];
    
    } else {
        [self.calculator appendToExpression:character];
    }
    
    
    [self updateUI];
}

- (void)updateUI {
    NSLog(@"updateUI");
    
    NSString *labelText = [self.calculator getExpressionString];
    // add padding on right
    labelText = [NSString stringWithFormat:@"%@", labelText];
    
    self.inputLabel.text = labelText;
}


//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"History"]) {
        HistoryVC *vc = [segue destinationViewController];
        vc.history = [self.calculator history];
    }
}
 
@end
