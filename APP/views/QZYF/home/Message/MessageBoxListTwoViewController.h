//
//  MessageBoxListViewController.h
//  APP
//
//  Created by PerryChen on 6/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseVC.h"

@protocol ContainerViewControllerDelegate;

@interface MessageBoxListTwoViewController : QWBaseVC
@property (nonatomic, weak) id<ContainerViewControllerDelegate>delegate;
@property (nonatomic, copy, readonly) NSArray *vcArray;

- (void)updateNaveBar;

@end

@protocol ContainerViewControllerDelegate <NSObject>
@optional
/** Informs the delegate that the user selected view controller by tapping the corresponding icon.
 @note The method is called regardless of whether the selected view controller changed or not and only as a result of the user tapped a button. The method is not called when the view controller is changed programmatically. This is the same pattern as UITabBarController uses.
 */
- (void)containerViewController:(MessageBoxListTwoViewController *)containerViewController didSelectViewController:(UIViewController *)viewController;

/// Called on the delegate to obtain a UIViewControllerAnimatedTransitioning object which can be used to animate a non-interactive transition.
- (id <UIViewControllerAnimatedTransitioning>)containerViewController:(MessageBoxListTwoViewController *)containerViewController animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;
@end
