<%--
  Created by IntelliJ IDEA.
  User: Лиза
  Date: 09.02.2021
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        <%@include file='css/style.css' %>
    </style>
    <title>Вторая лабораторная работа</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body onload="resizeFrame()">
<div id="container">
    <div id="header">
        Брованова Елизавета, группа P3231, вариант 2760
    </div>
    <br>
    <form>
        <div id="change">
            Выберите X:<br><br>
            <label><input type="checkbox" name="x" value="-5" onclick="chooseX()"/>-5</label>
            <label><input type="checkbox" name="x" value="-4" onclick="chooseX()"/>-4</label>
            <label><input type="checkbox" name="x" value="-3" onclick="chooseX()"/>-3</label><br>
            <label><input type="checkbox" name="x" value="-2" onclick="chooseX()"/>-2</label>
            <label><input type="checkbox" name="x" value="-1" onclick="chooseX()"/>-1</label>
            <label><input type="checkbox" name="x" value="0" onclick="chooseX()"/> 0</label><br>
            <label><input type="checkbox" name="x" value="1" onclick="chooseX()"/> 1</label>
            <label><input type="checkbox" name="x" value="2" onclick="chooseX()"/> 2</label>
            <label><input type="checkbox" name="x" value="3" onclick="chooseX()"/> 3</label><br>
            <p id="errorX"></p>
        </div>
        <div id="y">
            <label for="yValue">Введите Y:</label><br><br>
            <input type="text" id="yValue" placeholder="-3...5" onkeyup="validateY(this.value)"><br>
            <p id="errorY"></p>
        </div>
        <div id="r">
            <label for="rValue">Введите R:</label><br><br>
            <input type="text" id="rValue" placeholder="1...4" onkeyup="validateR(this.value)"><br>
            <p id="errorR"></p>
        </div>
        <div id="sendButton">
            <input id="send" type="button" name="send" value="Отправить" onclick="execute()">
        </div>
        <div id="clearButton">
            <input id="clear" type="button" name="clear" value="Очистить" onclick="clearTable()">
        </div>
        <p id="error"></p>
    </form>
    <div class="myCanvas">
        <canvas id="myCanvas" width="300px" height="300px" style="border:1px solid #d3d3d3"></canvas>
        <script>
            drawCanvas();
            function drawCanvas() {
                const canvas = document.getElementById("myCanvas");
                const g = canvas.getContext("2d");
                //треугольник
                g.fillStyle = "#3366cc";
                g.beginPath();
                g.moveTo(150, 150);
                g.lineTo(100, 150);
                g.lineTo(150, 200);
                g.fill();
                //четверть окружности
                g.beginPath();
                g.moveTo(150, 150);
                g.lineTo(100, 150);
                let cp2x = 150 - 35 * Math.sqrt(2);
                let cp2y = 150 - 35 * Math.sqrt(2);
                g.bezierCurveTo(100, 150, cp2x, cp2y, 150, 100);
                g.lineTo(150, 150);
                g.fill();
                // прямоугольник
                g.beginPath();
                g.fillRect(150, 150, 100, 100);
                g.fill();
                g.beginPath();
                //ось X
                g.moveTo(150,294.5);
                g.lineTo(150,5.5);
                g.lineTo(158,13.5);
                g.moveTo(150,5.5);
                g.lineTo(142,13.5);
                g.moveTo(155, 250);
                g.lineTo(145, 250);
                g.moveTo(155, 200);
                g.lineTo(145, 200);
                g.moveTo(155, 50);
                g.lineTo(145, 50);
                g.moveTo(155, 100);
                g.lineTo(145, 100);
                //ось Y
                g.moveTo(5.5,150);
                g.lineTo(294.5,150);
                g.lineTo(286.5,142);
                g.moveTo(294.5,150);
                g.lineTo(286.5,158);
                g.moveTo(100, 145);
                g.lineTo(100, 155);
                g.moveTo(50, 145);
                g.lineTo(50, 155);
                g.moveTo(200, 145);
                g.lineTo(200, 155);
                g.moveTo(250, 145);
                g.lineTo(250, 155);
                g.stroke();
                //подписи на осях
                g.fillStyle = 'black';
                g.font = "italic 10pt Arial";
                g.textAlign = "left";
                g.fillText("R", 155, 54);
                g.fillText("R/2", 155, 104);
                g.fillText("-R/2", 155, 204 );
                g.fillText("-R", 155, 254);
                g.fillText("-R", 44, 144);
                g.fillText("-R/2", 90, 144);
                g.fillText("R/2", 190, 144);
                g.fillText("R", 246, 144);
                canvas.addEventListener('click', handlerClickCanvas);
            }
            function handlerClickCanvas(e) {
                let canvas = document.getElementById("myCanvas");
                let g = canvas.getContext("2d");
                let r = document.getElementById("rValue").value;
                let error = document.getElementById("error");
                if (r !== ""){
                    error.innerHTML = "";
                    let rect = canvas.getBoundingClientRect();
                    let xCoordinate = e.clientX - rect.left - 150;
                    let yCoordinate = 150 - (e.clientY - rect.top);
                    let x = r / 100 * xCoordinate;
                    let y = r / 100 * yCoordinate;
                    createNewPoint(x, y, r);
                    //g.fillStyle = 'red';
                    //g.fillRect(150 + x / r * 100 - 2.5, 150 - y / r * 100 - 2.5, 5, 5);
                } else{
                    error.innerHTML = "Для определения координат точки введите R";
                }
            }
            function createNewPoint(x, y, r) {
                $.ajax({
                    url: "ControllerServlet.java?x=" + x + "&y=" + y + "&r=" + r,
                    method: 'get',
                    cache: false
                }).done(function (data) {
                    reloadFrame();
                    let canvas = document.getElementById("myCanvas");
                    let g = canvas.getContext("2d");
                    if (data.toString() ==="false"){
                        g.fillStyle = 'red';
                    } else (
                        g.fillStyle = '#0fff19'
                    );
                    g.fillRect(150 + x / r * 100 - 2.5, 150 - y / r * 100 - 2.5, 5, 5);
                });
            }
            function reloadFrame() {
                resizeFrame();
                document.getElementById('dataFrame').contentWindow.location.reload();
            }
        </script>
    </div>
    <div id="table">
        <iframe id="dataFrame" src="dataTable.jsp">
        </iframe>
    </div>
</div>
<script>
    function resizeFrame() {
        let iframe = document.querySelectorAll("iframe")[0];
        let body = iframe.contentWindow.document.body;
        iframe.width = body.scrollWidth;
        iframe.height = body.scrollHeight+21;
    }
    function clearFrame() {
        let iframe = document.querySelectorAll("iframe")[0];
        let body = iframe.contentWindow.document.body;
        iframe.width = body.scrollWidth + 20;
        iframe.height = 150;
    }
</script>
<script>
    let x;
    function execute() {
        let errors = document.getElementById("error");
        let y = document.getElementById("yValue").value;
        let r = document.getElementById("rValue").value;
        validateX();
        if (validateX() && validateY(y) && validateR(r)){
            errors.innerHTML = "";
            createNewPoint(x, y, r);
            const canvas =document.getElementById("myCanvas");
            const ctx = canvas.getContext("2d");
            ctx.fillStyle = 'red';
            ctx.fillRect(150 + x / r * 100 - 2.5, 150 - y / r * 100 - 2.5, 5, 5);
        } else {
            errors.innerHTML = "Вы ввели не все данные!"
        }
    }
    function clearTable() {
        let act = "clear";
        $.ajax({
            url: "ControllerServlet.java?act=" + act,
            method: 'get',
            cache: false
        }).done(function () {
            reloadFrame();
            clearFrame();
        });
        let canvas = document.getElementById("myCanvas");
        let ctx = canvas.getContext("2d");
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        drawCanvas();
    }
    function chooseX() {
        let arrayX = document.getElementsByName("x");
        let check = false;
        for (let i=0; i<arrayX.length; i++){
            arrayX[i].onchange = checkBoxHandler;
            if (check === false){
                x = null;
            }
        }
        function  checkBoxHandler() {
            for (let i=0; i<arrayX.length; i++){
                if (arrayX[i].checked && arrayX[i] !== this){
                    arrayX[i].checked = false;
                } else if (arrayX[i].checked && arrayX[i] === this){
                    x = arrayX[i].value;
                    check = true;
                }
            }
        }
    }
    function validateX() {
        let error = document.getElementById("errorX");
        if (x === undefined || x === null){
            error.innerHTML = "Вы не выбрали x!";
            return false;
        }
        error.innerHTML = "";
        return true;
    }
    function validateY(yValue){
        let y = yValue;
        let error = document.getElementById("errorY");
        if (y === "") {
            error.innerHTML = "Вы не ввели Y";
        } else if (isNaN(Number(y))){
            error.innerHTML = "Y должен быть числом";
        } else if (y <= -3 || y >= 5){
            error.innerHTML="Y должен быть больше -3 и меньше 5";
        } else {
            error.innerHTML="";
            return true;
        }
        return false;
    }
    function validateR(rValue) {
        let r = rValue;
        let error = document.getElementById("errorR");
        if (r === ""){
            error.innerHTML = "Вы не ввели R";
        } else if (isNaN(Number(r))) {
            error.innerHTML = "R должен быть числом";
        } else if (r <= 1 || r >= 4) {
            error.innerHTML = "R должен быть больше 1 и меньше 4";
        } else {
            error.innerHTML = "";
            return true;
        }
        return false;
    }
</script>
</body>
</html>
