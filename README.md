SVMSlidingTabBar
================

Sliding TabBar, A simple replacement for `UITabBarController`

PRE-NOTES:
 1. Done via XIB (_not Storyboard_)
 2. 98% Autolayout

This is a simple drop-in class with minimum code modifications.
Steps to set it up is almost identical to setting up a `UITabBarController`.

You have options to:
 1. Show any number of tabs and specify the number of tabs the user can see at a given time
   - `-initWithTabs:andTabsPerPage:andViewControllerArray:`
 2. Scroll right/left (when tab buttons are available)
 3. Enable/Disable/Hide/Show arrow indicators that indicate scrollable area
   - `-enableIndicators`
   - `-disableIndicators`
   - `-showIndicators`
   - `-hideIndicators`
 4. Display the tabBar button with images or plain text (preferably Unicode character images unless you abuse it for which it’s your loss)
 5. Delegates (_currently_)
   - `-didSelectViewController:`
   - `-shouldSelectViewController:`

----

To use **text** instead of an **image** for the tab button:
 1. Set `title` of a `UITabBarItem` object and set it onto the require `UIViewController`
 2. After initialising the `svmTabBar` object, call it’s `noImage` method

```
UITabBarItem *tabItem = [[UITabBarItem alloc] init];
[tabItem setTitle:@"🐶"];
[viewController setTabBarItem:tabItem];
```

----

Setting up Sliding TabBar:
```
svmObj = [[SVMSlidingTabBar alloc] initWithTabs:8 
                                 andTabsPerPage:5
                         andViewControllerArray:arrayOfViewControllers];
[svmObj setDelegate:self];
//to ignore UITabBarItem image settings and use viewController.tabBarItem.title for tab button
//[svmObj noImage];
[self addChildViewController:svmObj];
[svmObj didMoveToParentViewController:self];
[svmObj.view setFrame:self.view.frame];
[self.view addSubview:svmObj.view];

----

NOTE:
 1. The main class is `SVMSlidingTabBar`
 2. The `ViewController` class shows how the `SVMSlidingTabBar` component can be integrated
 3. The `FunctionalityTestVC` class shows how _some_ of the functionality of `SVMSlidingTabBar` can be modified on-the-fly
