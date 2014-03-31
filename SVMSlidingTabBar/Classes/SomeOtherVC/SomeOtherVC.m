//
//  SomeOtherVC.m
//  SVMSlidingTabBar
//
//  Created by staticVoidMan on 31/03/14.
//  Copyright (c) 2014 codewalla. All rights reserved.
//

#import "SomeOtherVC.h"
#import "SVMSlidingTabBar.h"

@interface SomeOtherVC ()

@end

@implementation SomeOtherVC

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

- (IBAction)btnStatus:(UIButton *)sender
{
    NSString *strSelectedViewController = [((SVMSlidingTabBar *)(self.parentViewController)).selectedViewController description];
    NSUInteger i_selectedIndex = ((SVMSlidingTabBar *)(self.parentViewController)).selectedIndex;

    NSLog(@"SelectedVC: %@",strSelectedViewController);
    NSLog(@"Selected Tab Index: %i",i_selectedIndex);
}

@end
