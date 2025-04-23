//
//  TodoTasksTableViewController.m
//  TaskyWorkshop
//
//  Created by JETSMobileLabMini10 on 23/04/2025.
//

#import "TodoTasksTableViewController.h"
#import "../datalayer/Task.h"
#import "../datalayer/TasksHelper.h"
#import "../addTask/AddTaskViewController.h"

@interface TodoTasksTableViewController ()

@property TasksHelper* helper;
@property NSMutableArray<Task*>* allTodoTasks;
@property NSMutableArray<Task*>* lowTasks;
@property NSMutableArray<Task*>* normalTasks;
@property NSMutableArray<Task*>* highTasks;

@end

@implementation TodoTasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.helper = [[TasksHelper alloc] init];
    self.allTodoTasks = [NSMutableArray new];
    self.lowTasks = [NSMutableArray new];
    self.normalTasks = [NSMutableArray new];
    self.highTasks = [NSMutableArray new];
    
    self.allTodoTasks = [[self.helper getTasksByState:TaskStateTodo] mutableCopy];
    self.lowTasks = [[self getListByPriority:TaskPriorityLow] mutableCopy];
    self.normalTasks = [[self getListByPriority:TaskPriorityNormal] mutableCopy];
    self.highTasks = [[self getListByPriority:TaskPriorityHigh] mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) getFreshData {
    self.allTodoTasks = [[self.helper getTasksByState:TaskStateTodo] mutableCopy];
    self.lowTasks = [[self getListByPriority:TaskPriorityLow] mutableCopy];
    self.normalTasks = [[self getListByPriority:TaskPriorityNormal] mutableCopy];
    self.highTasks = [[self getListByPriority:TaskPriorityHigh] mutableCopy];
    [self.tableView reloadData];
}

- (void)syncData {
    NSLog(@"data synced");
    [self getFreshData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Low";
            break;
            
        case 1:
            return @"Normal";
            break;
            
        case 2:
            return @"High";
            break;

        default:
            return @"NONE";
            break;
    }
}

-(NSArray*) getListByPriority:(TaskPriority) priority {
    NSMutableArray* result = [NSMutableArray new];
    
    for(int i = 0 ; i < self.allTodoTasks.count ; i++) {
        Task* currentTask = [self.allTodoTasks objectAtIndex:i];
        if(currentTask.taskPriority == priority) {
            [result addObject:currentTask];
        }
    }
    
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.lowTasks.count;
            break;
            
        case 1:
            return self.normalTasks.count;
            break;
            
        case 2:
            return self.highTasks.count;
            break;
            
        default:
            return [self getListByPriority:TaskPriorityLow].count;
            break;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    
    Task* currentTask;
    switch (indexPath.section) {
        case 0:
            currentTask = [self.lowTasks objectAtIndex:indexPath.row];
            break;
            
        case 1:
            currentTask = [self.normalTasks objectAtIndex:indexPath.row];
            break;
            
        case 2:
            currentTask = [self.highTasks objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    
    // Configure the cell...
    UILabel* titleLabel = [cell viewWithTag:1];
    titleLabel.text = currentTask.taskTitle;
    
    UIImageView* taskImageview = [cell viewWithTag:2];
    NSString* imagePath = [self getImagePathWithPriority: currentTask.taskPriority];
    taskImageview.image = [UIImage imageNamed: imagePath];
    
    UILabel* descLabel = [cell viewWithTag:3];
    descLabel.text = currentTask.taskDesc;
    
    UILabel* dateLabel = [cell viewWithTag:4];
    dateLabel.text = @"33.2/s34";
    
    UILabel* idLabel = [cell viewWithTag:5];
    idLabel.text = currentTask.taskId;
    
    
    return cell;
}

-(NSString*) getImagePathWithPriority: (TaskPriority) priority {
    switch (priority) {
        case TaskPriorityLow:
            return @"low";
            break;
            
        case TaskPriorityNormal:
            return @"normal";
            break;
            
        case TaskPriorityHigh:
            return @"high";
            break;
            
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        Task* selectedTask;
        
        switch (indexPath.section) {
            case 0:
                selectedTask = [self.lowTasks objectAtIndex:indexPath.row];
                [self.helper deleteTask:selectedTask];
                [self.lowTasks removeObject:selectedTask];
                break;
                
            case 1:
                selectedTask = [self.normalTasks objectAtIndex:indexPath.row];
                [self.helper deleteTask:selectedTask];
                [self.normalTasks removeObject:selectedTask];
                break;
            case 2:
                selectedTask = [self.highTasks objectAtIndex:indexPath.row];
                [self.helper deleteTask:selectedTask];
                [self.highTasks removeObject:selectedTask];
                break;
                
            default:
                break;
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"addTaskSegue"]) {
        
        AddTaskViewController* addTaskVC = [segue destinationViewController];
        addTaskVC.syncDataDelegate = self;
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
