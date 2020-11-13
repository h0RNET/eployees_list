package mironenko.employees_list.controllers;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import mironenko.employees_list.dto.EmployeeDto;
import mironenko.employees_list.services.EmployeeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@AllArgsConstructor
@RequestMapping("/employee")
@Log
public class EmployeeController {

    private final EmployeeServices employeeServices;

   /* @GetMapping("/list")
    @ResponseBody
    public List<EmployeeDto> getEmployeeList(){
        return employeeServices.employeesList();
    }*/

    @GetMapping("/list")
    public String getEmployeeList(Model model){
        List<EmployeeDto> employeeDtoList = employeeServices.employeesList();
        model.addAttribute("employeeList",employeeDtoList);
        return "employees";
    }

    @PostMapping("/add")
    @ResponseBody
    public EmployeeDto addEmployee(@RequestBody EmployeeDto employeeDto){
        return employeeServices.addOneEmployee(employeeDto);
    }

    @PutMapping("/update")
    @ResponseBody
    public EmployeeDto updateEmployee(@RequestBody EmployeeDto employeeDto){
        return employeeServices.updateOneEmployee(employeeDto);
    }

    @PutMapping("/dismiss/{idEmployee}")
    @ResponseBody
    public String dismissEmployee(@PathVariable(value = "idEmployee") UUID idEmployee){
        return employeeServices.dismissOneEmployee(idEmployee);
    }

    @DeleteMapping("/delete/{idEmployee}")
    @ResponseBody
    public void deleteEmployee(@PathVariable(value = "idEmployee") UUID idEmployee){
        employeeServices.deleteEmployee(idEmployee);
    }
}
