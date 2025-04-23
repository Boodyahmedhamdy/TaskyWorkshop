#import "TodoTasksTableViewController.h"
#import "../datalayer/Task.h"
#import "../datalayer/TasksHelper.h"
#import "../addTask/AddTaskViewController.h"
#import "../taskDetails/TaskDetailsViewController.h"

@interface TodoTasksTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property TasksHelper* helper;
@property NSMutableArray<Task*>* allTodoTasks;
@property NSMutableArray<Task*>* lowTasks;
@property NSMutableArray<Task*>* normalTasks;
@property NSMutableArray<Task*>* highTasks;
@property Task* selectedTask;

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
}

-(void) getFreshData {
    self.allTodoTasks = [[self.helper getTasksByState:TaskStateTodo] mutableCopy];
    self.lowTasks = [[self getListByPriority:TaskPriorityLow] mutableCopy];
    self.normalTasks = [[self getListByPriority:TaskPriorityNormal] mutableCopy];
    self.highTasks = [[self getListByPriority:TaskPriorityHigh] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self syncData];
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        Task* selectedTask;
//        NSString* message;
//        UIAlertController* alert;
//        UIAlertAction* cancelAction;
//        UIAlertAction* deleteAction;
//        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Task* selectedTask;
    switch (indexPath.section) {
        case 0:
            selectedTask = [self.lowTasks objectAtIndex:indexPath.row];
            break;
            
        case 1:
            selectedTask = [self.normalTasks objectAtIndex:indexPath.row];
            break;
            
        case 2:
            selectedTask = [self.highTasks objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    
    
    TaskDetailsViewController* taskDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsScreenId"];
    taskDetailsVC.currentTask = selectedTask;
    taskDetailsVC.syncDataDelegate = self;
    [self.navigationController pushViewController:taskDetailsVC animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@", searchText);
    self.allTodoTasks = [[self.helper searchTasksByTitle:searchText] mutableCopy];
    self.lowTasks = [[self getListByPriority:TaskPriorityLow] mutableCopy];
    self.normalTasks = [[self getListByPriority:TaskPriorityNormal] mutableCopy];
    self.highTasks = [[self getListByPriority:TaskPriorityHigh] mutableCopy];
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"addTaskSegue"]) {
        
        AddTaskViewController* addTaskVC = [segue destinationViewController];
        addTaskVC.syncDataDelegate = self;
        
    }
    
}


@end
