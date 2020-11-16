package mironenko.employees_list.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
    private String lastName;
    private String firstName;
    private String patronymic;
    private String position;
    private Date employmentDate;
    private Date dismissalDate;
    private String education;
    private boolean isDismissed;
    private Date birthDay;

    private int experience; //опыт работника высчитывается от начала даты работы до даты увольнения
}
