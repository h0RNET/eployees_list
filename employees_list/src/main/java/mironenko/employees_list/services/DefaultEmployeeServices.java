package mironenko.employees_list.services;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import mironenko.employees_list.converters.EmployeeDtoConverter;
import mironenko.employees_list.dto.EmployeeDto;
import mironenko.employees_list.model.Employee;
import mironenko.employees_list.repositories.EmployeeRepository;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@AllArgsConstructor
@Log
public class DefaultEmployeeServices implements EmployeeServices {

    private final EmployeeRepository employeeRepository;
    private final EmployeeDtoConverter employeeDtoConverter;

    @Override
    public List<EmployeeDto> employeesList() {
        List<EmployeeDto> employeeDtoList = new ArrayList<>();
        List<Employee> employeeList = employeeRepository.findAll();
        Calendar calendar = new GregorianCalendar();
        for (Employee temp : employeeList) {
            employeeDtoList.add(employeeDtoConverter.fromEmployeeToEmployeeDto(temp));
        }
        setExperience(employeeDtoList);
        return employeeDtoList;
    }

    @Override
    public EmployeeDto getOneEmployee(UUID idEmployee) {
        Employee employee = employeeRepository.findByIdEmployee(idEmployee);
        return employeeDtoConverter.fromEmployeeToEmployeeDto(employee);
    }

    @Override
    public EmployeeDto addOneEmployee(EmployeeDto employeeDto) {
        Employee employee = employeeDtoConverter.fromEmployeeDtoToEmployee(employeeDto);
        employeeRepository.save(employee);
        return employeeDtoConverter.fromEmployeeToEmployeeDto(employee);
    }

    @Override
    public void deleteEmployee(UUID idEmployee) {
        employeeRepository.deleteById(idEmployee);
    }

    @Override
    public EmployeeDto updateOneEmployee(EmployeeDto employeeDto) {
        Employee employee = employeeDtoConverter.fromEmployeeDtoToEmployee(employeeDto);
        employeeRepository.save(employee);
        return employeeDtoConverter.fromEmployeeToEmployeeDto(employee);
    }

    @Override
    public String dismissOneEmployee(UUID idEmployee) {
        EmployeeDto employeeDto = getOneEmployee(idEmployee);
        Date date = new Date();
        employeeDto.setDismissalDate(date);
        employeeDto.setDismissed(true);
        Employee employee = employeeDtoConverter.fromEmployeeDtoToEmployee(employeeDto);
        employeeRepository.save(employee);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(date);
    }

    private List<EmployeeDto> setExperience(List<EmployeeDto> employeeDtoList) {
        Calendar calendar = new GregorianCalendar();
        int experience = 0;
        for (EmployeeDto temp : employeeDtoList) {
            calendar.setTime(temp.getEmploymentDate());
            int emplMounth = calendar.get(Calendar.MONTH);
            int emplYear = calendar.get(Calendar.YEAR);
            if(temp.getDismissalDate() != null){
                calendar.setTime(temp.getDismissalDate());
                int dismMounth = calendar.get(Calendar.MONTH);
                int dismYear = calendar.get(Calendar.YEAR);
                experience = dismYear - emplYear;
                if(experience > 0 && (dismMounth-emplMounth) < 0){
                    experience --;
                }
            }
            else{
                Date date = new Date();
                calendar.setTime(date);
                int currentYear = calendar.get(Calendar.YEAR);
                int currentMonth = calendar.get(Calendar.MONTH);
                experience = currentYear - emplYear;
                if(experience > 0 && (currentMonth-emplMounth) < 0){
                    experience --;
                }
            }
            temp.setExperience(experience);
        }
        return employeeDtoList;
    }
}



