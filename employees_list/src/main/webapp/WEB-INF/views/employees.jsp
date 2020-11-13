<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.css">

    <script>
        var operateEvents = {
            'click .bi-trash': function (e, value, row) { //удаление сотрудника из списка и БД по клику на мусорку
                $.ajax({
                    method: "Delete",
                    url: "/employee/delete/" + row._id,
                    data: row._id,
                    success: function () {
                        $('#' + row._id).remove();
                    }
                })
            },
            'click .btn-warning': function (e, value, row) { //увольнение сотрудника и выставление даты увольнения
                $.ajax({
                    method: "Put",
                    url: "/employee/dismiss/" + row._id,
                    data: row._id,
                    success: function (data) {
                        let tdDsms = $("#"+row._id).children('.dismissalDate');
                        tdDsms.text(data);
                    }
                })
            }
        }
    </script>
</head>

<body>
<div class="container">
    <h2 align="center">Список сотрудников </h2><br>
    Добавить сотрудника
    <table id="table1"
           data-toggle="table"
           data-search="true"
           data-pagination="true"
           data-height="500"
           data-sortable="true"
           data-sort-name="fullName">
        <thead>
        <tr>
            <th data-sortable="true" data-field="fullName">ФИО</th>
            <th data-sortable="true">Должность</th>
            <th data-sortable="true">Стаж</th>
            <th data-sortable="true">День рождения</th>
            <th data-sortable="true">Дата увольнения</th>
            <th data-sortable="false" data-halign="center" data-events="operateEvents">Действие</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeList}" var="employee">
            <tr id="${employee.idEmployee}">
                <td class="fullName">${employee.lastName} ${employee.firstName} ${employee.patronymic}</td>
                <td class="position">${employee.position}</td>
                <td class="experience">${employee.experience}</td>
                <td class="birthDay">${employee.birthDay}</td>
                <td class="dismissalDate">${employee.dismissalDate}</td>
                <td>
                    <button type="button" class="btn btn-warning mx-lg-3"
                            <c:if test="${employee.dismissed == true}"> <%--если сотрудник уволен--%>
                                <c:out value="disabled"></c:out> <%--вставляем атрибут disabled--%>
                            </c:if>
                    >Уволить
                    </button>

                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil mx-lg-2" fill="currentColor"
                         xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                              d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                    </svg>

                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor"
                         xmlns="http://www.w3.org/2000/svg">
                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                        <path fill-rule="evenodd"
                              d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                    </svg>

                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
        crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.js"></script>
</html>