//
//  SVMSlidingTabBar.m
//  SVMSlidingTabBar
//
//  Created by staticVoidMan on 20/01/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//
//  https://github.com/staticVoidMan/SVMSlidingTabBar.git

#import "SVMSlidingTabBar.h"

@interface SVMSlidingTabBar ()
{
    NSInteger i_btnCount;   //total number of tab buttons
    NSInteger i_btnWidth;   //width of tab button
    NSInteger i_btnHeight;  //height of tab button

    NSInteger i_btnCountPerTab;

    NSInteger i_barMaxWidthPerButton;
    NSInteger i_barMaxPaddingPerButton;
    
    NSInteger i_tabBtnCurrentSelection; //current button selected

    NSInteger i_tabPageCount;           //number of tab pages
    NSInteger i_tabPageCurrentIndex;    //current tab page in view

    BOOL showIndicators;
    BOOL isImage;
}
@end

@implementation SVMSlidingTabBar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithTabs:(NSInteger)tabButtonCount andTabsPerPage:(NSInteger)tabButtonPerPage andViewControllerArray:(NSArray *)viewControllers
{
    self = [super initWithNibName:@"SVMSlidingTabBar" bundle:nil];
    if (self) {
        i_btnCount = tabButtonCount;
        i_btnCountPerTab = tabButtonPerPage;
        isImage = YES;

        self.viewControllers = viewControllers;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self createSVMTabBar];
}

#pragma mark - Create SVMTabBar
-(void)createSVMTabBar
{
    i_btnWidth = 44;
    i_btnHeight = 44;

    i_tabPageCount = ceil((float)i_btnCount/(float)i_btnCountPerTab);

    if (i_btnCount > i_btnCountPerTab) {
        i_barMaxWidthPerButton = self.svTabBar.frame.size.width / i_btnCountPerTab;
    } else {
        i_barMaxWidthPerButton = self.svTabBar.frame.size.width / i_btnCount;
    }

    i_barMaxPaddingPerButton = (i_barMaxWidthPerButton - i_btnWidth)/2;

    for (int i = 0 ; i < i_btnCount; i++) {
        //---viewControllers
        UIViewController *vcCurrent = self.viewControllers[i];
        [self addChildViewController:vcCurrent];
        [vcCurrent didMoveToParentViewController:self];
        [vcCurrent.view setFrame:vwContainer.frame];
        [vcCurrent.view setHidden:YES];
        [vwContainer addSubview:vcCurrent.view];

        //---Buttons
        UIButton *btnTab = [UIButton buttonWithType:UIButtonTypeSystem];
        [btnTab addTarget:self action:@selector(btnTabAct:) forControlEvents:UIControlEventTouchUpInside];
        [btnTab setTag:(i+1)];
        [btnTab setTintColor:[UIColor colorWithRed:0.0f green:0.1f blue:0.05f alpha:0.2f]];

        if (isImage) {
            [btnTab setImage:vcCurrent.tabBarItem.finishedUnselectedImage forState:UIControlStateNormal];
            [btnTab setImage:vcCurrent.tabBarItem.finishedSelectedImage forState:UIControlStateSelected];
            [btnTab setImageEdgeInsets:vcCurrent.tabBarItem.imageInsets];
        } else {
            [btnTab.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:36.0f]];

            [btnTab setTitle:vcCurrent.tabBarItem.title forState:UIControlStateNormal];
            [btnTab setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            [btnTab setTitle:vcCurrent.tabBarItem.title forState:UIControlStateSelected];
            [btnTab setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        }
        [btnTab setFrame:CGRectMake((i*i_barMaxWidthPerButton)+i_barMaxPaddingPerButton, 0, i_btnWidth, i_btnHeight)];
        [self.svTabBar addSubview:btnTab];
    }

    NSInteger i_tabBarWidth = i_tabPageCount * self.svTabBar.frame.size.width;
    [self.svTabBar setContentSize:CGSizeMake(i_tabBarWidth, self.svTabBar.frame.size.height)];

    [self defaultSettings];
}

-(void)noImage
{
    isImage = NO;
}

#pragma mark - SVMTabBar Navigation Logic
//Navigate to the Right
- (IBAction)gesSwipeLeftOnTabBarAct:(UISwipeGestureRecognizer *)sender
{
    CGPoint svOffsetNext = self.svTabBar.contentOffset;
    svOffsetNext.x += self.svTabBar.frame.size.width;

    if (i_tabPageCurrentIndex < i_tabPageCount) {
        i_tabPageCurrentIndex++;
        [self.svTabBar setContentOffset:svOffsetNext animated:YES];

        if (showIndicators) {
            if (btnMoreIndicatorLeft.hidden) {
                [btnMoreIndicatorLeft setHidden:NO];
            }
            if (i_tabPageCurrentIndex == i_tabPageCount) {
                if (! btnMoreIndicatorRight.hidden) {
                    [btnMoreIndicatorRight setHidden:YES];
                }
            }
        }
    }
}

//Navgiate to the Left
- (IBAction)gesSwipeRightOnTabBarAct:(UISwipeGestureRecognizer *)sender
{
    CGPoint svOffsetNext = self.svTabBar.contentOffset;
    svOffsetNext.x -= self.svTabBar.frame.size.width;

    if (i_tabPageCurrentIndex != 1) {
        i_tabPageCurrentIndex--;
        [self.svTabBar setContentOffset:svOffsetNext animated:YES];

        if (showIndicators) {
            if (btnMoreIndicatorRight.hidden) {
                [btnMoreIndicatorRight setHidden:NO];
            }
            if (i_tabPageCurrentIndex == 1) {
                if (! btnMoreIndicatorLeft.hidden) {
                    [btnMoreIndicatorLeft setHidden:YES];
                }
            }
        }
    }
}

#pragma mark - Tab Button method
-(void)btnTabAct:(UIButton *)sender
{
    BOOL shouldContinue = YES;

    if ([self.delegate respondsToSelector:@selector(svmSlidingTabBarController:shouldSelectViewController:)]) {
        UIViewController *vcCurrent = self.viewControllers[i_tabBtnCurrentSelection-1];
        shouldContinue = [self.delegate svmSlidingTabBarController:self shouldSelectViewController:vcCurrent];
    }

    if (shouldContinue) {
        [self changeSelectedIndex:sender.tag];

        if ([self.delegate respondsToSelector:@selector(svmSlidingTabBarController:didSelectViewController:)]) {
            UIViewController *vcCurrent = self.viewControllers[i_tabBtnCurrentSelection-1];
            [self.delegate svmSlidingTabBarController:self didSelectViewController:vcCurrent];
        }
    }
}

#pragma mark - Selection logic
-(void)defaultSettings
{
    showIndicators = YES;
    i_tabPageCurrentIndex = 1;

    //default tag
    [self setTabTag:1];

    //tab button
    UIButton *btn = (UIButton *)([self.svTabBar viewWithTag:i_tabBtnCurrentSelection]);
    [btn setSelected:YES];

    //viewController
    UIViewController *vc = self.viewControllers[i_tabBtnCurrentSelection-1];
    [vc.view setHidden:NO];

    self.selectedViewController = vc;
}

-(void)changeSelectedIndex:(NSInteger)newTag
{
    //---OLD
    //old tab button
    UIButton *btnCurrent = (UIButton *)([self.svTabBar viewWithTag:i_tabBtnCurrentSelection]);
    [btnCurrent setSelected:NO];

    //old viewController
    UIViewController *vcCurrent = self.viewControllers[i_tabBtnCurrentSelection-1];
    [vcCurrent.view setHidden:YES];

    //---NEW
    //change tag
    [self setTabTag:newTag];

    //new tab button
    UIButton *btnAfter = (UIButton *)([self.svTabBar viewWithTag:i_tabBtnCurrentSelection]);
    [btnAfter setSelected:YES];

    //new viewController
    UIViewController *vcAfter = self.viewControllers[i_tabBtnCurrentSelection-1];
    [vcAfter.view setHidden:NO];

    self.selectedViewController = vcAfter;
}

-(void)setTabTag:(NSInteger)tag
{
    i_tabBtnCurrentSelection = tag;
    self.selectedIndex = i_tabBtnCurrentSelection;
}

#pragma mark - SVMTabBar Right/Left More Indicators
#pragma mark Indicator Button Methods
-(IBAction)btnMoreIndicatorLeftAct:(id)sender
{
    [self gesSwipeRightOnTabBarAct:nil];
}

-(IBAction)btnMoreIndicatorRightAct:(id)sender
{
    [self gesSwipeLeftOnTabBarAct:nil];
}

#pragma mark Show/Hide Indicators
-(void)showIndicators
{
    if (! showIndicators) {
        showIndicators = YES;

        if (i_tabPageCurrentIndex != 1) {
            [btnMoreIndicatorLeft setHidden:NO];
            if (i_tabPageCurrentIndex < i_tabPageCount) {
                [btnMoreIndicatorRight setHidden:NO];
            }
        } else {
            [btnMoreIndicatorRight setHidden:NO];
        }
    }
}

-(void)hideIndicators
{
    if (showIndicators) {
        showIndicators = NO;

        if (! btnMoreIndicatorLeft.hidden) {
            [btnMoreIndicatorLeft setHidden:YES];
        }
        if (! btnMoreIndicatorRight.hidden) {
            [btnMoreIndicatorRight setHidden:YES];
        }
    }
}

#pragma mark Enable/Disable Indicators
-(void)enableIndicators
{
    if (! btnMoreIndicatorLeft.enabled || ! btnMoreIndicatorRight.enabled) {
        [btnMoreIndicatorLeft setEnabled:YES];
        [btnMoreIndicatorRight setEnabled:YES];
    }
}

-(void)disableIndicators
{
    if (btnMoreIndicatorLeft.enabled || btnMoreIndicatorRight.enabled) {
        [btnMoreIndicatorLeft setEnabled:NO];
        [btnMoreIndicatorRight setEnabled:NO];
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (i_btnCount > i_btnCountPerTab) {
        i_barMaxWidthPerButton = self.svTabBar.frame.size.width / i_btnCountPerTab;
    } else {
        i_barMaxWidthPerButton = self.svTabBar.frame.size.width / i_btnCount;
    }
    i_barMaxPaddingPerButton = (i_barMaxWidthPerButton - i_btnWidth)/2;

    NSInteger i = 0;
    for (UIView *vwCurrent in self.svTabBar.subviews) {
        if ([vwCurrent isKindOfClass:[UIButton class]]) {
            UIButton *btnCurrent = (UIButton *)vwCurrent;
            [btnCurrent setFrame:CGRectMake((i*i_barMaxWidthPerButton)+i_barMaxPaddingPerButton, 0, i_btnWidth, i_btnHeight)];
            i++;
        }
    }

    NSInteger i_syncXPos = (i_tabPageCurrentIndex-1) * self.svTabBar.frame.size.width;
    [self.svTabBar setContentOffset:CGPointMake(i_syncXPos, self.svTabBar.contentOffset.y) animated:NO];
}

@end
