# 🍅 LMS Tomato

A full-featured **Learning Management System (LMS)** built using **Java Servlets, JSP, and JDBC**, following the **MVC (Model-View-Controller)** architecture.

This platform enables students to enroll in courses, track progress, submit assignments, while admins manage users, courses, and enrollments efficiently.

---

## 🚀 Features

### 👨‍🎓 Student Features
- Browse available courses
- Enroll in courses
- Access lessons and learning materials
- Track learning progress
- Submit assignments
- Manage personal profile

### 👩‍💼 Admin Features
- Admin dashboard
- Manage users
- Manage courses
- Manage enrollments
- Monitor platform activity

### 🔐 Authentication
- User registration & login
- Role-based access (Admin / Student)

---

## 🧑‍💻 Tech Stack

### Backend
- **Java (Servlets)**
- **JDBC (Java Database Connectivity)**
- **DAO Pattern** for database operations

### Frontend
- **JSP (Java Server Pages)**
- **HTML, CSS**
- Reusable JSP components (Navbar, Footer, Sidebar)

### Architecture
- **MVC Architecture**
  - Model → Java classes (entities)
  - View → JSP pages
  - Controller → Servlets

### Build Tool
- **Apache Maven**

### Server
- **Apache Tomcat** (or any Servlet container)

---

## 📂 Project Structure

LMS-Tomato/
│
├── pom.xml                # Maven dependencies
├── src/
│   └── main/
│       ├── java/
│       │   └── com/tomatolms/
│       │       ├── controller/   # Servlets (Controller layer)
│       │       ├── dao/          # Database access layer
│       │       ├── model/        # Entity classes (Model layer)
│       │       └── util/         # Utility classes (DB connection)
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml       # Servlet configuration
│           │
│           ├── components/       # Reusable UI parts
│           ├── css/              # Stylesheets
│           ├── images/           # Static assets
│           │
│           ├── views/
│           │   ├── admin/        # Admin pages
│           │   ├── public/       # Login/Register
│           │   └── student/      # Student dashboard
│           │
│           ├── index.jsp         # Landing page
│           ├── about.jsp
│           └── add-courses.jsp

---

## 🧠 Architecture Explanation

### 🔹 Model (`model/`)
Represents database entities:
- User
- Course
- Assignment
- Enrollment
- Lesson
- Progress
- Submission

---

### 🔹 DAO Layer (`dao/`)
Handles all database operations:
- CRUD operations
- Queries for courses, users, enrollments, etc.

---

### 🔹 Controller (`controller/`)
Servlets that handle:
- HTTP requests (GET/POST)
- Business logic
- Routing between views and backend

Examples:
- `AuthServlet` → Login/Register
- `CourseServlet` → Course management
- `EnrollmentServlet` → Enrollment logic

---

### 🔹 View (`webapp/`)
JSP-based UI:
- Dynamic content rendering
- Reusable components (navbar, footer)
- Separate dashboards for admin & student

---

## ⚙️ Setup & Installation

### 1️⃣ Clone the Repository
```bash id="x0k9a1"
git clone https://github.com/1012ayush/LMS-Tomato.git
cd LMS-Tomato

2️⃣ Configure Database
	•	Create a database (MySQL recommended)
	•	Update DB credentials in:DBConnection.java

3️⃣ Build Project (Maven)
   mvn clean install

4️⃣ Deploy on Tomcat
	•	Copy generated .war file to:tomcat/webapps/
  •	Start Tomcat server

⸻

5️⃣ Run Application

Open browser: http://localhost:8080/LMS-Tomato

📸 Application Modules
	•	🏠 Home Page (index.jsp)
	•	🔐 Authentication (Login/Register)
	•	📚 Course Management
	•	🎓 Student Dashboard
	•	🛠️ Admin Dashboard
	•	📊 Progress Tracking

⸻

🔮 Future Enhancements
	•	Payment Integration 💳
	•	Email Notifications 📧
	•	File Upload for Assignments 📂
	•	REST API integration 🌐
	•	Responsive UI improvements 📱

⸻

🤝 Contributing
	1.	Fork the repository
	2.	Create a feature branch
	3.	Commit changes
	4.	Push and create Pull Request

⸻

🐞 Issues

Feel free to open issues for bugs or feature requests.

⸻

📄 License

This project is licensed under the MIT License.

⸻

👨‍💻 Author

Ayush
GitHub: https://github.com/1012ayush
