//
//  TaskDetailsViewController.h
//  TaskyWorkshop
//
//  Created by JETSMobileLabMini10 on 23/04/2025.
//

#import <UIKit/UIKit.h>
#import "../datalayer/Task.h"
#import "../SyncDataDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskDetailsViewController : UIViewController

@property Task* currentTask;
@property id<SyncDataDelegate> syncDataDelegate;

@end

NS_ASSUME_NONNULL_END
