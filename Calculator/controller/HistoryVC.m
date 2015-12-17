//
//  HistoryVC.m
//  Calculator
//
//  Created by User on 12/17/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import "HistoryVC.h"

@interface HistoryVC ()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryVC

@synthesize history = _history;

- (void)setHistory:(History *)history {
    _history = history;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *historyStr = [self.history history];
    self.historyTextView.text = historyStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
