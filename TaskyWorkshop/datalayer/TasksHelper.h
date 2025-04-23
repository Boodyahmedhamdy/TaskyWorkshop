//
//  TasksHelper.h
//  TaskyWorkshop
//
//  Created by JETSMobileLabMini10 on 23/04/2025.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TasksHelper : NSObject

@property NSUserDefaults* df;

-(NSArray<Task*> *) getAllTasks;
-(NSArray<Task*> *) getTasksByState: (TaskState) state;
-(NSArray<Task*> *) getTasksByPriority: (TaskPriority) priority;

-(void) addTask: (Task*) task;
-(void) updateTask: (Task*) task;
-(void) deleteTask: (Task*) task;

@end

NS_ASSUME_NONNULL_END
