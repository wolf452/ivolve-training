# Task: Role-based Authorization in Jenkins

## Objective
Create two users in Jenkins:
- **user1** with **Admin** role.
- **user2** with **Read-only** role.

## Steps to Complete the Task

### 1. Install the **Role-Based Authorization Strategy** Plugin

Before setting up roles, ensure that the **Role-Based Authorization Strategy** plugin is installed in Jenkins.
![install plug](https://github.com/user-attachments/assets/07aaabf7-13ad-49e6-95aa-f4929b2e39f6)

- Go to **Manage Jenkins** > **Manage Plugins**.
- In the **Available** tab, search for **Role-based Authorization Strategy**.
- Install the plugin and restart Jenkins if required.

### 2. Enable Role-Based Authorization

- Navigate to **Manage Jenkins** > **Configure Global Security**.
- Under the **Authorization** section, select **Role-Based Strategy**.
- Click **Save** to apply the changes.
![choose](https://github.com/user-attachments/assets/faec4c65-b450-46e0-aa57-d7c5d05120ff)

### 3. Create Roles

Now you need to define two roles:
- **Admin Role**: Full access to Jenkins management features.
- **Read-Only Role**: View-only access to projects without modification rights.

#### Admin Role:
- Go to **Manage Jenkins** > **Manage and Assign Roles** > **Manage Roles**.
- Create a role named **admin** and check the following permissions:
  - **Overall/Administer**: Full administrative rights.
  
#### Read-Only Role:
- Create a role named **readonly** and check the following permissions:
  - **Job/Read**: Permission to view job configurations and builds.
  - **View/Read**: Permission to view Jenkins views and their contents.
![role](https://github.com/user-attachments/assets/ae64c081-082b-4818-89bc-fd6c7bb3f902)

### 4. Create Users

Create two users, **user1** and **user2**, either through the Jenkins interface or by using a script.

For example, to create users via the Jenkins UI:
- Go to **Manage Jenkins** > **Manage Users**.
- Click **Create User** and add **user1** and **user2** with their respective credentials.
![create user](https://github.com/user-attachments/assets/14549f86-0510-4292-954c-10424024dccc)

### 5. Assign Roles to Users

- Go to **Manage Jenkins** > **Manage and Assign Roles** > **Assign Roles**.
- Under **Assign Roles**, assign the **admin** role to **user1** and the **readonly** role to **user2**.
![assignrole](https://github.com/user-attachments/assets/06c7eb1c-f048-43de-b715-861637723d03)

### 6. Test the Roles

- **user1**: Log in as **user1** and verify that they have full administrative rights (e.g., can create, configure, and delete jobs).
  ![allow](https://github.com/user-attachments/assets/386517c8-37b3-4dde-8111-e34ed2fe817a)

- **user2**: Log in as **user2** and verify that they can only view jobs and job results but cannot modify or delete anything.
![deny](https://github.com/user-attachments/assets/2703d0e5-7466-4530-a68f-c58a4765b0e4)

## Conclusion

By following the steps above, you have successfully set up role-based access control in Jenkins with **user1** as an admin and **user2** with read-only access.
