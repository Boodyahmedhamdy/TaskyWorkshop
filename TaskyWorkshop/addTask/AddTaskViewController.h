//
//  AddTaskViewController.h
//  TaskyWorkshop
//
//  Created by JETSMobileLabMini10 on 23/04/2025.
//

#import <UIKit/UIKit.h>
#import "../SyncDataDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UIViewController


@property id<SyncDataDelegate> syncDataDelegate;

@end

NS_ASSUME_NONNULL_END
