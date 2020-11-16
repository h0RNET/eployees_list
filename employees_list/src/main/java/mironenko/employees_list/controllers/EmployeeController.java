package mironenko.employees_list.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import mironenko.employees_list.dto.EmployeeDto;
import mironenko.employees_list.services.EmployeeServices;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@Controller
@AllArgsConstructor
@RequestMapping("/employee")
@Tag(name = "EmployeeController", description = "Реализация REST сервиса")
public class EmployeeController {

    private final EmployeeServices employeeServices;
    
    @GetMapping("/list")
    public String getEmployeeList(Model model){
        List<EmployeeDto> employeeDtoList = employeeServices.employeesList();
        model.addAttribute("employeeList",employeeDtoList);
        return "employees";
    }


    @Operation(summary = "Добавление сотрудника")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "успешная операция"),
            @ApiResponse(responseCode = "400", description = "неверный формат запроса"),
            @ApiResponse(responseCode = "500", description = "внутренняя ошибка сервера")
    })
    @PostMapping(value = "/add", produces = "application/json")
    @ResponseBody
    public EmployeeDto addEmployee(@RequestBody EmployeeDto employeeDto){
        return employeeServices.addOneEmployee(employeeDto);
    }


    @Operation(summary = "Обновление информации сотрудника")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "успешная операция"),
            @ApiResponse(responseCode = "400", description = "неверный формат запроса"),
            @ApiResponse(responseCode = "500", description = "внутренняя ошибка сервера")
    })
    @PutMapping(value = "/update", produces = "application/json")
    @ResponseBody
    public EmployeeDto updateEmployee(@RequestBody EmployeeDto employeeDto){
        return employeeServices.updateOneEmployee(employeeDto);
    }


    @Operation(summary = "Увольнение сотрудника")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "успешная операция"),
            @ApiResponse(responseCode = "400", description = "неверный формат запроса"),
            @ApiResponse(responseCode = "404", description = "строка не найдена", content = @Content(mediaType = "application/json")),
            @ApiResponse(responseCode = "500", description = "внутренняя ошибка сервера")
    })
    @PutMapping("update/dismiss/{idEmployee}")
    @ResponseBody
    public String dismissEmployee(@PathVariable(value = "idEmployee") UUID idEmployee){
        try {
            return employeeServices.dismissOneEmployee(idEmployee);
        }catch (RuntimeException e){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }


    @Operation(summary = "Удаление сотрудника")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "успешная операция"),
            @ApiResponse(responseCode = "400", description = "неверный формат запроса"),
            @ApiResponse(responseCode = "404", description = "строка не найдена", content = @Content(mediaType = "application/json")),
            @ApiResponse(responseCode = "500", description = "внутренняя ошибка сервера")
    })
    @DeleteMapping("/delete/{idEmployee}")
    @ResponseBody
    public void deleteEmployee(@PathVariable(value = "idEmployee") UUID idEmployee){
        try{
            employeeServices.deleteEmployee(idEmployee);
        }catch (RuntimeException e){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }
}
