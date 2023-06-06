package be.nicholas.aws.resources.employee.data;

import be.nicholas.aws.resources.employee.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface EmployeeDataRepository extends JpaRepository<Employee, UUID> {

}
