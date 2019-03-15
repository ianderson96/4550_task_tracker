# 4550_task_tracker
Task tracker app for web dev project
# Design decisions made for Part 1:

User assignment: I decided to do the user assignment similarly to the cart example from class. I have a TaskLists table, with list_items inside. These are essentially user-task pairs that are used to assign tasks to users and this is referenced to find out who has the tasks assigned to them. I also used an "upsert" method so that a task cannot be assigned to two users at once. I repurposed the "show" template for the user assignment because I didn't feel it was 100% needed.

Minutes: I used a select field so that users can choose 15-minute increments, up to 48 hours. I created a function to generate these minute values with their paired labels for the select field.

# Design Decisions made for Part 2:

For this assignment, I chose to make managers very limited and only focus on assigning tasks and managing users. Because of this, managers cannot have any tasks assigned to them, and they cannot themselves have managers. I also chose to make managers the only users who can create and assign tasks - regular users can only see the tasks assigned to them, while managers can see all tasks. The Users index page is only available for admin users.

For time blocks, I chose to have them linked to the task and not the user who created the time block. Thus, anybody who can view the edit page can add timeblocks (only users to which the task is assigned and managers).



