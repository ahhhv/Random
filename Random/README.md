# Random User Coding Challenge

## Task

You are working for a company showing random users information (**RandomUser Inc.**). As a good company based on random users data, they want to show random information about random users.

Your task for this code test is to design an **Android/iOS application** (the one you prefer) with these requirements:

- **Download** a list of random users from [RandomUser API](http://randomuser.me/).
- Be careful, some users **can be duplicated**. You should take this into account and **do not show duplicated users**. If the API returns the same user more than once, you must store just **one** instance of that user inside your system.

## Features

### **User List**
Display a list of random users with the following information:
- **User name and surname**
- **User email**
- **User picture**
- **User phone**

### **Infinite Scroll or Load More**
- Add a **button** or any **infinite scroll mechanism** to **retrieve more users** and add them to your current list.

### **User Deletion**
- Add a **button** or similar interaction to **delete users**.
- If a user is deleted, they **should not reappear** in the list even if they are part of a **new server-side response**.

### **User Search**
- The UI should contain a **search box** to **filter users by name, surname, or email**.
- Once the user stops typing, the list should be **updated with matching users**.

### **User Details**
If the user taps on a list item, navigate to a **detail view** displaying:
- **User gender**
- **User name and surname**
- **User location** (street, city, and state)
- **Registered date**
- **User email**
- **User picture**

### **Data Persistence**
- The user list should be **persistent across application sessions**.
- If the user sees "John Smith" as the first contact, he should **always** see the same contact **in that position** until they remove it or uninstall the app.

## Testing & Code Quality
- **Test your code**, focusing on the most important parts of your application.
- Think about **architecture** and **design**, keeping the project **modular**.
- **Avoid over-engineering** and find a **good balance** between modularization and readability.
