package be.nicholas.aws.resources.employee.mapper;

import be.nicholas.aws.resources.employee.model.Employee;
import be.nicholas.aws.resources.employee.resource.EmployeeWebResponseResource;

import java.util.List;

public interface EmployeeMapper {
    EmployeeWebResponseResource modelToResource(final Employee employee);

    List<EmployeeWebResponseResource> modelToResource(final List<Employee> employees);
}
