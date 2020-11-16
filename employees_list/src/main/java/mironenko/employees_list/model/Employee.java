package mironenko.employees_list.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "employee_list")
@NoArgsConstructor
@Data
@ToString
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(length = 16)
    private UUID idEmployee; //ид сотрудника

    private String lastName; //Фамилия
    private String firstName; //Имя
    private String patronymic; //Отчество
    private String position; //Должность
    private String education; //Образование
    private boolean isDismissed; //уволен или нет

    @Temporal(TemporalType.DATE)
    private Date birthDay; //дата рождения в формате "yyyy-MM-dd"
    @Temporal(TemporalType.DATE)
    private Date employmentDate; //дата принятия на работу в формате "yyyy-MM-dd"
    @Temporal(TemporalType.DATE)
    private Date dismissalDate; //дата увольнения в формате "yyyy-MM-dd"
}
