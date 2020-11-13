package mironenko.employees_list.repositories;

import mironenko.employees_list.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;


public interface EmployeeRepository extends JpaRepository<Employee, UUID> {
    Employee findByIdEmployee(UUID idEmployee);
}
