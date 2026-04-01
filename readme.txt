================================================================================
                               LMS TOMATO
================================================================================

DESCRIPTION
-----------
LMS TOMATO is a robust and fully functional E-Learning Management System built 
using the classic Java enterprise tech stack. It provides a comprehensive 
platform for both administrators and students to manage, teach, and learn 
educational content effectively.

FEATURES
--------
* Two User Roles: Administrator and Student
* Authentication System: Secure Login and Registration logic.
* Admin Dashboard: 
    - Full Course Management: create, edit, and delete courses.
    - Enrollment Management: approve or reject student enrollments.
* Student Dashboard: 
    - Browse and enroll in "Featured", "All", and specific categorized courses.
    - "My Courses" section to track active and pending enrollments.
    - View course contents, progress, and assignments.
* Polished UI/UX: Interactive and responsive design utilizing a tomato-red 
  thematic styling.

TECH STACK
----------
* Backend: Java (Servlets), JDBC
* Frontend: HTML5, CSS3, JSP, JSTL
* Database: MySQL
* Server: Apache Tomcat 7
* Build Tool: Apache Maven

SETUP AND INSTALLATION
----------------------
1. Database Configuration:
   - Create a MySQL database named `tomato_lms`.
   - Apply the provided database schema (or allow the initial scripts to run).
   - Ensure the `users`, `courses`, `enrollments`, and other relevant tables 
     are created.
   
2. Application Configuration:
   - Open `src/main/java/com/tomatolms/util/DBConnection.java`.
   - Update the `URL`, `USERNAME`, and `PASSWORD` constants to match your local 
     MySQL database credentials.

3. Running the Application:
   - Make sure you are in the project root directory containing the `pom.xml`.
   - Run the following Maven command to compile the project and start the server:
     > mvn clean tomcat7:run
   - Open your web browser and navigate to:
     http://localhost:8080/

DEFAULT CREDENTIALS (if configured via fallback script)
-------------------------------------------------------
Admin Account:
Email: admin@tomatolms.com
Password: admin123

================================================================================
Happy Learning!
