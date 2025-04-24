
# 📝 Todo Tasks iOS App (Objective-C)

This is a simple yet powerful **Todo Tasks** application built using **Objective-C** for iOS. It allows users to manage tasks effectively using different states and priorities. The app is designed with clean, user-friendly interfaces and includes a range of task management features such as creating, updating, searching, and filtering tasks.

---

## 🚀 Features

- 📋 **Todo Screen**  
  View the list of tasks that are yet to be started.

- 🔄 **In Progress Screen**  
  Shows tasks that are currently in progress.

- ✅ **Done Screen**  
  Displays tasks that have been completed.

- ➕ **Add Task**  
  Create new tasks with a title and assign them a priority level: `Low`, `Normal`, or `High`.

- ✏️ **Update Task**  
  Edit task details including title, state (`Todo`, `In Progress`, `Done`), and priority.

- 🗑️ **Delete Task**  
  Swipe to delete any task easily from the list.

- 🔍 **Search Tasks**  
  Search for tasks by their title using a convenient search bar.

- 🎯 **Filter by Priority**  
  Filter the task list by priority level to focus on the most important tasks.

---

## 🛠️ Technical Details

- **Language:** Objective-C  
- **Architecture:** MVC (Model-View-Controller)  
- **UI:** Built with UIKit using `UITableViewController`  
- **Data Persistence:** `NSUserDefaults` (or specify if you're using CoreData or another mechanism)  
- **Screens:**
  - TodoViewController
  - InProgressViewController
  - DoneViewController
  - AddEditTaskViewController

- **Task Model Includes:**
  - `title` (NSString)
  - `priority` (enum or NSString – Low, Normal, High)
  - `state` (enum – Todo, InProgress, Done)

---

## 📷 Screenshots

_Add your app screenshots here if available._

---

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/todo-tasks-ios-app.git
