package be.nicholas.aws.resources.employee.service;

import be.nicholas.aws.resources.employee.data.EmployeeDataRepository;
import be.nicholas.aws.resources.employee.model.Employee;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    private final EmployeeDataRepository repository;

    public EmployeeService(EmployeeDataRepository repository) {
        this.repository = repository;
    }

    public List<Employee> findAll() {
        return repository.findAll();
    }
}
