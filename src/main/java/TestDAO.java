import com.tomatolms.dao.CourseDAO;
import com.tomatolms.model.Course;
import java.util.List;

public class TestDAO {
    public static void main(String[] args) {
        System.out.println("--- Starting TestDAO ---");
        try {
            CourseDAO dao = new CourseDAO();
            List<Course> courses = dao.getAllCourses();
            System.out.println("Returned " + courses.size() + " courses from getAllCourses.");
            for (Course c : courses) {
                System.out.println("ID: " + c.getId() + " Title: " + c.getTitle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
