package mironenko.employees_list.converters;

import mironenko.employees_list.dto.EmployeeDto;
import mironenko.employees_list.model.Employee;
import org.springframework.stereotype.Component;

@Component
public class EmployeeDtoConverter {
    public EmployeeDto fromEmployeeToEmployeeDto(Employee employee){
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setIdEmployee(employee.getIdEmployee());
        employeeDto.setLastName(employee.getLastName());
        employeeDto.setFirstName(employee.getFirstName());
        employeeDto.setPatronymic(employee.getPatronymic());
        employeeDto.setPosition(employee.getPosition());
        employeeDto.setEmploymentDate(employee.getEmploymentDate());
        employeeDto.setDismissalDate(employee.getDismissalDate());
        employeeDto.setEducation(employee.getEducation());
        employeeDto.setBirthDay(employee.getBirthDay());
        employeeDto.setDismissed(employee.isDismissed());
        return employeeDto;
    }

    public Employee fromEmployeeDtoToEmployee(EmployeeDto employeeDto){
        Employee employee = new Employee();
        employee.setIdEmployee(employeeDto.getIdEmployee());
        employee.setLastName(employeeDto.getLastName());
        employee.setFirstName(employeeDto.getFirstName());
        employee.setPatronymic(employeeDto.getPatronymic());
        employee.setPosition(employeeDto.getPosition());
        employee.setEmploymentDate(employeeDto.getEmploymentDate());
        employee.setDismissalDate(employeeDto.getDismissalDate());
        employee.setEducation(employeeDto.getEducation());
        employee.setBirthDay(employeeDto.getBirthDay());
        employee.setDismissed(employeeDto.isDismissed());
        return employee;
    }
}
