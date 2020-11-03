package mironenko.employees_list.services;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import mironenko.employees_list.converters.EmployeeDtoConverter;
import mironenko.employees_list.dto.EmployeeDto;
import mironenko.employees_list.model.Employee;
import mironenko.employees_list.repositories.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class DefaultEmployeeServices implements EmployeeServices{

    private final EmployeeRepository employeeRepository;
    private final EmployeeDtoConverter employeeDtoConverter;

    @Override
    public List<EmployeeDto> employeesList() {
        List<EmployeeDto> employeeDtoList = new ArrayList<>();
        List<Employee> employeeList = employeeRepository.findAll();
        for(Employee temp : employeeList){
            employeeDtoList.add(employeeDtoConverter.fromEmployeeToEmployeeDto(temp));
        }
        return employeeDtoList;
    }

    @Override
    public EmployeeDto getOneEmployee(UUID idEmployee) {
        return null;
    }

    @Override
    public EmployeeDto addOneEmployee(EmployeeDto employeeDto) {
        return null;
    }

    @Override
    public void deleteEmployee(UUID idEmployee) {

    }

    @Override
    public EmployeeDto updateOneEmployee(EmployeeDto employeeDto) {
        return null;
    }
}



