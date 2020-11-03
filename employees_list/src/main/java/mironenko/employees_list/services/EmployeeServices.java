package mironenko.employees_list.services;

import mironenko.employees_list.dto.EmployeeDto;

import java.util.List;
import java.util.UUID;

public interface EmployeeServices {
    public List<EmployeeDto> employeesList();
    public EmployeeDto getOneEmployee(UUID idEmployee);
    public EmployeeDto addOneEmployee(EmployeeDto employeeDto);
    public void deleteEmployee(UUID idEmployee);
    public EmployeeDto updateOneEmployee(EmployeeDto employeeDto);
}
