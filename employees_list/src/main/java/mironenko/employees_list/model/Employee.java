package mironenko.employees_list.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "employee_list")
@NoArgsConstructor
@Data
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID idEmployee;

    private String organization;
    private String lastName;
    private String firstName;
    private String patronymic;
    private String position;

    @Temporal(TemporalType.DATE)
    private Date employmentDate;
    @Temporal(TemporalType.DATE)
    private Date dismissalDate;


    private String education;

    @Column(length = 4)
    @Size(min = 4, max = 4)
    private int graduatedYear;
}
