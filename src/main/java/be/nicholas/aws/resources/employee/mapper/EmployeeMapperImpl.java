package be.nicholas.aws.resources.employee.mapper;

import be.nicholas.aws.resources.employee.model.Employee;
import be.nicholas.aws.resources.employee.resource.EmployeeWebResponseResource;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class EmployeeMapperImpl implements EmployeeMapper{
    @Override
    public EmployeeWebResponseResource modelToResource(Employee employee) {
        return new EmployeeWebResponseResource(employee.getId(), employee.getJob());
    }

    @Override
    public List<EmployeeWebResponseResource> modelToResource(List<Employee> employees) {
        return employees.stream().map(this::modelToResource).collect(Collectors.toList());
    }
}
