package mironenko.employees_list.controllers;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import mironenko.employees_list.dto.EmployeeDto;
import mironenko.employees_list.services.EmployeeServices;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/employee")
@Log
public class EmployeeController {

    private final EmployeeServices employeeServices;

    @GetMapping
    @ResponseBody
    public List<EmployeeDto> getEmployeeList(){
        return employeeServices.employeesList();
    }
}
