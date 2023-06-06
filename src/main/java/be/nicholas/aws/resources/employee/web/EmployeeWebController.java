package be.nicholas.aws.resources.employee.web;

import be.nicholas.aws.resources.employee.mapper.EmployeeMapper;
import be.nicholas.aws.resources.employee.resource.EmployeeWebResponseResource;
import be.nicholas.aws.resources.employee.service.EmployeeService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/employee")
public class EmployeeWebController {

    private final EmployeeService service;
    private final EmployeeMapper mapper;

    public EmployeeWebController(EmployeeService service, EmployeeMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @GetMapping
    public ResponseEntity<List<EmployeeWebResponseResource>> findAll() {
        return ResponseEntity.ok(mapper.modelToResource(service.findAll()));
    }
}
