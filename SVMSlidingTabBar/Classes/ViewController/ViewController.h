//
//  ViewController.h
//  SVMSlidingTabBar
//
//  Created by staticVoidMan on 29/03/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVMSlidingTabBar.h"

@interface ViewController : UIViewController <SVMSlidingTabBarDelegate, UITabBarControllerDelegate>
{
    SVMSlidingTabBar *svmObj;
}

@end
