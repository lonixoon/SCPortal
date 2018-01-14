<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            font-size: 15px;
            background: #EBEFF2;
            font-family: sans-serif;
        }

        .container {
            padding: 0 10px 10px 10px;
        }

        .problem-list {
            list-style: none;
            padding: 0;
        }

        .problem-list__item {
            background: #ffffff;
            border: 1px solid #aaa;
            border-radius: 5px;
            margin-bottom: 10px;
            padding: 10px;
        }

        .btn {
            background: #5FBEAA;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 7px;
            text-decoration: none;
            cursor: pointer;
        }

        .input-file {
            padding-left: 7px;
            width: 230px;
            background-color: #FFFFFF;
            border: 1px solid #5FBEAA;
            border-radius: 3px;
            height: 26px;
            overflow: hidden;
            position: relative;
            text-align: left;
            vertical-align: middle;
        }

        .input-file__btn {
            background-color: #5FBEAA;
            color: #FFFFFF;
            float: right;
            height: 100%;
            line-height: 20px;
            overflow: hidden;
            padding: 3px 6px;
            text-align: center;
            width: 50px;
            font-family: inherit;
            font-size: inherit;
        }

        #upload {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            -moz-opacity: 0;
            filter: alpha(opacity=0);
            opacity: 0;
            font-size: 150px;
            height: 30px;
            z-index: 20;
        }

        .input-file__label {
            background-color: #FFFFFF;
            float: left;
            height: 22px;
            line-height: 22px;
            overflow: hidden;
            padding: 2px;
            text-align: left;
            vertical-align: middle;
            width: 160px;
        }

        .error-red {
            display: inline-block;
            padding: 10px;
            border: 1px solid #f0726d;
            border-radius: 3px;
            background: #FCDCDC;
            color: #f05050;
        }

        .problem-list__title {
            cursor: text;
        }

        .input-file:hover {
            border-color: #5bab96;
        }

        .input-file:hover .input-file__btn,
        .btn:hover {
            background-color: #5bab96;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>Разбор файла Daily Status HelpDesk по активностям (проблемам)</h3>
    @yield('form')
    @yield('content')
</div>
{{--<script src="{{ asset('js/main.js') }}"></script>--}}
<script>
    function getFileName(str) {
        let i;
        if (str.lastIndexOf('\\')) {
            i = str.lastIndexOf('\\') + 1;
        }
        else {
            i = str.lastIndexOf('/') + 1;
        }
        let filename = str.slice(i);
        let uploaded = document.querySelector('.input-file__label');
        uploaded.innerHTML = filename;
    }

    function checkNumber() {
        let checkboxAll = document.querySelectorAll('input[type=checkbox]').length;
        if (checkboxAll > 0) {
            let checkboxChecked = document.querySelectorAll('input[type=checkbox]:checked').length;
            document.getElementById("checkboxNoChecked").innerHTML = checkboxAll;
            let tiketLeft = checkboxAll - checkboxChecked;
            let checkboxCheckDiv = document.getElementById("checkboxChecked");
            if (tiketLeft <= 4 && tiketLeft >= 2) {
                checkboxCheckDiv.innerHTML = tiketLeft + ' тикета';
            } else if (tiketLeft === 1) {
                checkboxCheckDiv.innerHTML = tiketLeft + ' тикет';
            } else {
                checkboxCheckDiv.innerHTML = tiketLeft + ' тикетов';
            }
        }

    }
    checkNumber();
</script>
</body>
</html>