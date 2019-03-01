# 4550_task_tracker
Task tracker app for web dev project
Design decisions made:

User assignment: I decided to do the user assignment similarly to the cart example from class. I have a TaskLists table, with list_items inside. These are essentially user-task pairs that are used to assign tasks to users and this is referenced to find out who has the tasks assigned to them. I also used an "upsert" method so that a task cannot be assigned to two users at once. I repurposed the "show" template for the user assignment because I didn't feel it was 100% needed.

Minutes: I used a select field so that users can choose 15-minute increments, up to 48 hours. I created a function to generate these minute values with their paired labels for the select field.


