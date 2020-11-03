package mironenko.employees_list.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class EmployeeDto {
    private UUID idEmployee;
    private String organization;
    private String lastName;
    private String firstName;
    private String patronymic;
    private String position;
    private Date employmentDate;
    private Date dismissalDate;
    private String education;
    private int graduatedYear;
}
