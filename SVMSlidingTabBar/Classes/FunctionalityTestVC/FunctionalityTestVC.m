//
//  FunctionalityTestVC.m
//  SVMSlidingTabBar
//
//  Created by staticVoidMan on 30/03/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//

#import "FunctionalityTestVC.h"
#import "SVMSlidingTabBar.h"

@interface FunctionalityTestVC ()

@end

@implementation FunctionalityTestVC

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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnShowIndicatorsAct:(UIButton *)sender
{
    [(SVMSlidingTabBar *)(self.parentViewController) showIndicators];
}

- (IBAction)btnHideIndicatorsAct:(UIButton *)sender
{
    [(SVMSlidingTabBar *)(self.parentViewController) hideIndicators];
}

- (IBAction)btnEnableIndicatorsAct:(UIButton *)sender
{
    [(SVMSlidingTabBar *)(self.parentViewController) enableIndicators];
}

- (IBAction)btnDisableIndicatorsAct:(UIButton *)sender
{
    [(SVMSlidingTabBar *)(self.parentViewController) disableIndicators];
}

- (IBAction)btnStatus:(UIButton *)sender
{
    NSString *strSelectedViewController = [((SVMSlidingTabBar *)(self.parentViewController)).selectedViewController description];
    NSUInteger i_selectedIndex = ((SVMSlidingTabBar *)(self.parentViewController)).selectedIndex;

    NSLog(@"SelectedVC: %@",strSelectedViewController);
    NSLog(@"Selected Tab Index: %i",i_selectedIndex);
}


@end
