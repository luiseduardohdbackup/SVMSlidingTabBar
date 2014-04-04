//
//  ViewController.m
//  SVMSlidingTabBar
//
//  Created by staticVoidMan on 29/03/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//

#import "ViewController.h"
#import "FunctionalityTestVC.h"
#import "SomeOtherVC.h"

@interface ViewController ()

@end

@implementation ViewController

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
    [self setUpSVMTabBar];
}

-(void)setUpSVMTabBar
{
    NSInteger i_numberOfViewController = 11;
    NSInteger i_numberOfTabsPerPage = 4;

    NSMutableArray *arrViewControllers = [[NSMutableArray alloc] init];

    FunctionalityTestVC *vc1 = [[FunctionalityTestVC alloc] initWithNibName:@"FunctionalityTestVC" bundle:nil];
    UITabBarItem *tabItem1 = [[UITabBarItem alloc] init];
    [tabItem1 setFinishedSelectedImage:[UIImage imageNamed:@"wolf-cartoon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"wolf-cartoon.png"]];
    [tabItem1 setImageInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [vc1 setTabBarItem:tabItem1];
    [arrViewControllers addObject:vc1];

    SomeOtherVC *vc2 = [[SomeOtherVC alloc] initWithNibName:@"SomeOtherVC" bundle:nil];
    UITabBarItem *tabItem2 = [[UITabBarItem alloc] init];
    [tabItem2 setFinishedSelectedImage:[UIImage imageNamed:@"pet-dog.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"pet-dog.png"]];
    [tabItem2 setImageInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [vc2 setTabBarItem:tabItem2];
    [arrViewControllers addObject:vc2];

    UIViewController *vc3 = [[UIViewController alloc] init];
    UITabBarItem *tabItem3 = [[UITabBarItem alloc] init];
    [tabItem3 setFinishedSelectedImage:[UIImage imageNamed:@"radioactive.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"radioactive.png"]];
    [tabItem3 setImageInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [vc3.view setBackgroundColor:[UIColor colorWithRed:(float)((arc4random()%255)/255.0) green:(float)((arc4random()%255)/255.0) blue:(float)((arc4random()%255)/255.0) alpha:1]];
    [vc3 setTabBarItem:tabItem3];
    [arrViewControllers addObject:vc3];

    UIViewController *vc4 = [[UIViewController alloc] init];
    UITabBarItem *tabItem4 = [[UITabBarItem alloc] init];
    [tabItem4 setFinishedSelectedImage:[UIImage imageNamed:@"soccer.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"soccer.png"]];
    [tabItem4 setImageInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [vc4.view setBackgroundColor:[UIColor colorWithRed:(float)((arc4random()%255)/255.0) green:(float)((arc4random()%255)/255.0) blue:(float)((arc4random()%255)/255.0) alpha:1]];
    [vc4 setTabBarItem:tabItem4];
    [arrViewControllers addObject:vc4];

    for (int i = 3; i < i_numberOfViewController; i++) {
        UITabBarItem *tabItem = [[UITabBarItem alloc] init];
        [tabItem setFinishedSelectedImage:[UIImage imageNamed:@"spiral.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"spiral.png"]];
        [tabItem setImageInsets:UIEdgeInsetsMake(7, 7, 7, 7)];

        UIViewController *vcCurrent = [[UIViewController alloc] init];
        [vcCurrent.view setBackgroundColor:[UIColor colorWithRed:(float)((arc4random()%255)/255.0) green:(float)((arc4random()%255)/255.0) blue:(float)((arc4random()%255)/255.0) alpha:1]];
        [vcCurrent setTabBarItem:tabItem];

        [arrViewControllers addObject:vcCurrent];
    }

    svmObj = [[SVMSlidingTabBar alloc] initWithTabs:i_numberOfViewController andTabsPerPage:i_numberOfTabsPerPage andViewControllerArray:arrViewControllers];
    [svmObj setDelegate:self];
    [self addChildViewController:svmObj];
    [svmObj didMoveToParentViewController:self];
    [svmObj.view setFrame:self.view.frame];
    [self.view addSubview:svmObj.view];

    [svmObj.svTabBar setBackgroundColor:[UIColor colorWithRed:0.1f green:0.2f blue:0.1f alpha:0.5]];
}

#pragma mark - SVMSlidingTabBar Delegates
-(BOOL)svmSlidingTabBarController:(SVMSlidingTabBar *)svmTabBar shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"shouldSelect \t-- %d : %@",svmTabBar.selectedIndex, viewController);
    return YES;
}

-(void)svmSlidingTabBarController:(SVMSlidingTabBar *)svmTabBar didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"didSelect \t\t-- %d : %@",svmTabBar.selectedIndex, viewController);
}

@end
