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
        //события, которые происходят внутри таблицы
        var operateEvents = {
            'click .bi-trash': function (e, value, row) { //удаление сотрудника из списка и БД по клику на мусорку
                $.ajax({
                    method: "Delete",
                    url: "/employee/delete/" + row._id,
                    success: function () {
                        $('#' + row._id).remove();
                    }
                })
            },
            'click .btn-warning': function (e, value, row) { //увольнение сотрудника и выставление даты увольнения
                $.ajax({
                    method: "Put",
                    url: "/employee/update/dismiss/" + row._id,
                    success: function (data) {
                        let tdDsms = $("#" + row._id).children('.dismissalDate');
                        tdDsms.text(data);
                    }
                })
            },
            'click .bi-pencil': function (e, value, row) { // редактирование пользователя
                $('#action').modal('show');
                let idEmployee = row._id;
                let fullName = $('#' + row._id).children('.fullName').text().split(' ');
                let position = $('#' + row._id).children('.position').text();
                let education = $('#' + row._id).children('.education').text();
                let birthDay = $('#' + row._id).children('.birthDay').text();
                let employmentDate = $('#' + row._id).children('.employmentDate').text();
                let dismissalDate = $('#' + row._id).children('.dismissalDate').text();

                $('#formLastName').val(fullName[0]);
                $('#formFirstName').val(fullName[1]);
                $('#formPatronymic').val(fullName[2]);
                $('#formPosition').val(position);
                $('#formEducation').val(education);
                $('#formBirthDay').val(birthDay);
                $('#formEmploymentDate').val(employmentDate);
                $('#formDismissalDate').val(dismissalDate);

                $('#modalForm').on('submit', function (e) {
                    console.log($('#formDismissalDate').val().length)
                    let dataToSend = JSON.stringify({
                        idEmployee: idEmployee,
                        lastName: $('#formLastName').val(),
                        firstName: $('#formFirstName').val(),
                        patronymic: $('#formPatronymic').val(),
                        position: $('#formPosition').val(),
                        education: $('#formEducation').val(),
                        birthDay: $('#formBirthDay').val(),
                        employmentDate: $('#formEmploymentDate').val(),
                        dismissalDate: $('#formDismissalDate').val(),
                        dismissed: ($('#formDismissalDate').val().length == 0) ? false : true
                    })
                    console.log(dataToSend)
                    $.ajax({
                        method: "put",
                        url: "/employee/update/",
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        data: dataToSend,
                        success: function () {
                            alert("Сотрудник в списке обновлён")
                        }
                    })
                })
            }
        }
    </script>
    <script>
        //события за таблицей
        $(document).ready(function () {
            $('#addEmployee').click(function () { //добавление пользователя
                $('#action').modal('show');
                $('#modalForm').on('submit', function () {
                    let dataToSend = JSON.stringify({
                        lastName: $('#formLastName').val(),
                        firstName: $('#formFirstName').val(),
                        patronymic: $('#formPatronymic').val(),
                        position: $('#formPosition').val(),
                        education: $('#formEducation').val(),
                        birthDay: $('#formBirthDay').val(),
                        employmentDate: $('#formEmploymentDate').val(),
                        dismissalDate: $('#formDismissalDate').val(),
                        dismissed: ($('formDismissalDate').val() == '') ? false : true
                    })

                    $.ajax({
                        method: "post",
                        url: "/employee/add/",
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        data: dataToSend,
                        success: function () {
                            alert("Сотрудник добавлен в список")
                        }
                    })
                })
            })

            //очистка формы модального окна
            $('#reset').click(function () {
                $('#action').trigger('clear');
                $('#action').modal('hide');
            })

            $('#exportList').click(function () {
                $('#table1').bootstrapTable('destroy');
                $('#table1').tableExport({
                    type: 'csv',
                    fileName: 'employeeList',
                })
                $('#table1').bootstrapTable();
            })
        })
    </script>
    <style type="text/css">
        .links {
            cursor: pointer;
        }

        .underlined {
            border-bottom: 1px solid black !important;
        }

        .icons-color {
            fill: #e85c12;
        !important;
        }

        .container-my {
        @extend . container;
            max-width: 1260px;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>

<body>
<div class="container">
    <h2 align="center">Список сотрудников </h2><br>
    <svg width="1.2em" height="1.2em" viewBox="0 0 16 16" class="bi bi-download icons-color" fill="currentColor"
         xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd"
              d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"/>
        <path fill-rule="evenodd"
              d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z"/>
    </svg>
    <span role="button" class="links mr-lg-5 underlined" id="exportList">Экспорт списка</span>
    <svg width="1.2em" height="1.2em" viewBox="0 0 16 16" class="bi bi-plus-circle-fill icons-color" fill="currentColor"
         xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd"
              d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/>
    </svg>
    <span role="button" class="links underlined" id="addEmployee">Добавить сотрудника</span>
</div>
<div class="container-my">
    <table id="table1"
           data-toggle="table"
           data-search="true"
           data-pagination="true"
           data-height="500"
           data-sortable="true"
           data-sort-name="fullName">
        <thead>
        <tr>
            <th data-sortable="true" data-field="fullName" data-width="200">ФИО</th>
            <th data-sortable="true">Должность</th>
            <th data-sortable="true">Стаж</th>
            <th data-sortable="false">Образование</th>
            <th data-sortable="true">Дата рождения</th>
            <th data-sortable="true">Дата принятия на работу</th>
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
                <td class="education">${employee.education}</td>
                <td class="birthDay">${employee.birthDay}</td>
                <td class="employmentDate">${employee.employmentDate}</td>
                <td class="dismissalDate">${employee.dismissalDate}</td>
                <td>
                    <button type="button" class="btn btn-warning mx-lg-3"
                            <c:if test="${employee.dismissed == true}"> <%--если сотрудник уволен--%>
                                <c:out value="disabled"></c:out> <%--вставляем атрибут disabled--%>
                            </c:if>
                    >Уволить
                    </button>

                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil mx-lg-2 links"
                         fill="currentColor"
                         xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                              d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                    </svg>

                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash links" fill="currentColor"
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

<%--MODAL WINDOW--%>
<div class="modal fade" id="action" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <form id="modalForm">
                    <div class="form-group">
                        <label for="formLastName"><b>Фамилия</b></label>
                        <input type="text" class='form-control' id="formLastName" required/>
                    </div>
                    <div class="form-group">
                        <label for="formFirstName"><b>Имя</b></label>
                        <input type="text" class='form-control' id="formFirstName" required/>
                    </div>
                    <div class="form-group">
                        <label for="formPatronymic"><b>Отчество</b></label>
                        <input type="text" class='form-control' id="formPatronymic" required/>
                    </div>
                    <div class="form-group">
                        <label for="formPosition"><b>Должность</b></label>
                        <input type="text" class='form-control' id="formPosition" required/>
                    </div>
                    <div class="form-group">
                        <label for="formEducation"><b>Образование</b></label>
                        <input type="text" class='form-control' id="formEducation" required/>
                    </div>
                    <div class="form-group">
                        <label for="formBirthDay"><b>Дата рождения</b></label>
                        <input type="date" class='form-control' id="formBirthDay" required/>
                    </div>
                    <div class="form-group">
                        <label for="formEmploymentDate"><b>Дата принятия на работу</b></label>
                        <input type="date" class='form-control' id="formEmploymentDate" required/>
                    </div>
                    <div class="form-group">
                        <label for="formDismissalDate"><b>Дата увольнения</b>(не обязательно)</label>
                        <input type="date" class='form-control' id="formDismissalDate"
                               placeholder="Необязательное поле"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type='reset' form="modalForm" id="reset" class="btn btn-secondary">Закрыть окно</button>
                <input type="submit" form="modalForm" class="btn btn-primary" value="Сохранить"></input>
            </div>
        </div>
    </div>
</div>

</body>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
        crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.js"></script>
<script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>
<script src="https://unpkg.com/bootstrap-table@1.18.0/dist/extensions/export/bootstrap-table-export.min.js"></script>
</html>