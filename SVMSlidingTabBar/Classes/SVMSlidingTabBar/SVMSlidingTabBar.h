//
//  SVMSlidingTabBar.h
//  SVMSlidingTabBar
//
//  Created by staticVoidMan on 20/01/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//
//  https://github.com/staticVoidMan/SVMSlidingTabBar.git

#import <UIKit/UIKit.h>

@class SVMSlidingTabBar;
@protocol SVMSlidingTabBarDelegate <NSObject>
@optional
/*
 Asks the delegate whether the specified view controller should be made active.
 The tab bar controller calls this method in response to the user tapping a tab bar item.
 You can use this method to dynamically decide whether a given tab should be made the active tab.
 */
-(BOOL)svmSlidingTabBarController:(SVMSlidingTabBar *)svmTabBar shouldSelectViewController:(UIViewController *)viewController;

/*
 Tells the delegate that the user selected an item in the tab bar.
 */
-(void)svmSlidingTabBarController:(SVMSlidingTabBar *)svmTabBar didSelectViewController:(UIViewController *)viewController;
@end

@interface SVMSlidingTabBar : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIView *vwContainer;
    
    IBOutlet UISwipeGestureRecognizer *gesSwipeLeftOnTabBar;
    IBOutlet UISwipeGestureRecognizer *gesSwipeRightOnTabBar;

    IBOutlet UIButton *btnMoreIndicatorRight;
    IBOutlet UIButton *btnMoreIndicatorLeft;
}

@property (nonatomic, strong) IBOutlet UIScrollView *svTabBar;

@property (nonatomic, copy) NSArray *viewControllers;

@property (nonatomic,assign) UIViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, assign) id <SVMSlidingTabBarDelegate> delegate;

#pragma mark - Main Method
-(id)initWithTabs:(NSInteger)tabButtonCount andTabsPerPage:(NSInteger)tabButtonPerPage andViewControllerArray:(NSArray *)viewControllers;

#pragma mark - SVMTabBar Right/Left More Indicators
#pragma mark Show/Hide Indicators
-(void)showIndicators;
-(void)hideIndicators;

#pragma mark Enable/Disable Indicator Methods
-(void)enableIndicators;
-(void)disableIndicators;

@end
