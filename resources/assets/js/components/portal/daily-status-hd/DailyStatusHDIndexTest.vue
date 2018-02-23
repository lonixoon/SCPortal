<template>
    <div>
        <!--<router-link to="/" class="btn btn-default">Назад</router-link>-->
        <div class="col-md-12 form-group">
            <h3>Разбор файла Daily Status HelpDesk по активностям (проблемам)</h3>
            <div class="alert alert-info">
                <p>
                    После нажатия кнопки создать, начнётся отправка тикета
                    (процесс занимает обычно занимает 30 – 60 секунд, зависит от скорости работы Афины).
                    Как появится номер - тикет создан и отправлен на RUS L2 – Helpdesk.
                </p>
                <p>
                    Тыкайте кнопочки Создать подряд и после ждите номера.
                </p>
            </div>
        </div>
        <div class="row">
            <form class="col-md-3" id="uploadForm" name="uploadForm" enctype="multipart/form-data"
                  v-if="lists === null">
                <div class="form-group">
                    <input class="btn btn-default" type='file' accept='.rtf' name='file' id='upload' required>
                </div>
                <div class="form-group">
                    <button id="buttonSubmit" type="button" class="btn btn-primary" @click="uploadFiles">
                        Загрузить
                    </button>
                </div>
            </form>
        </div>
        <div v-show="errorDailyStatusHd" class="alert alert-danger">Не удалось обработать данные</div>
        <div class="col-md-12" v-if="tiketNumbers.length > 0">
            Здесь будут все ваши тикеты в виде одной строки (для удобства копирования):
            <p>{{ tiketNumbers.join(', ') }}</p>
        </div>
        <div class="row" v-for="(list, key) in lists" style="margin-bottom: 30px;">
            <div v-if="key == 'catalogFromGica'">
                <div class="col-md-12">
                    <table style="margin-bottom: 0" class="table table-bordered table-striped">
                        <tbody>
                        <tr>
                            <th class="col-md-2">Тикет</th>
                            <th class="col-md-3">Intagrate catalog to stores</th>
                            <th class="col-md-7">Ситы</th>
                        </tr>
                        </tbody>
                    </table>
                    <form v-bind:id="problem" method="post" v-for="(cites, problem) in list">
                        <table style="margin-bottom: 0" class="table table-bordered table-hover">
                            <tbody>
                            <tr>
                                <!--Визульная часть-->
                                <td class="col-md-2" v-model="tiketNumbers" v-bind:id="problem + '_tiket'">
                                    <button v-bind:id="problem + '_create'" type="button" class="btn btn-success btn-xs"
                                            @click="crateTiket(problem)">
                                        Создать
                                    </button>
                                    <span v-bind:id="problem + '_number'"></span>
                                </td>
                                <td class="col-md-3">{{ problem }}</td>
                                <td class="col-md-7">{{ citesList(cites) }}</td>
                                <!--<td class="col-md-7">{{ crateText(problem, cites) }}</td>-->

                                <!--Скратая часть - отправка формы с параметрами-->
                                <input name="title" v-bind:value="problem" hidden>
                                <input name="textTiket" v-bind:value="crateText(problem, cites)" hidden>
                                <input name="nameGroup" value="RUS L2 - Helpdesk" hidden>
                                <input name="citName" value="999R - Multiple Sites Russia" hidden>
                                <input name="citId" value="3680" hidden>
                                <input name="cimPriority" value="2" hidden>
                                <input name="typeTiket" value="Incident" hidden>
                                <input name="topicNameTiket" value="TECHNICAL/AS400_NPI/APPLICATION" hidden>
                                <input name="topicId" value="181902" hidden>
                                <!--<input name="topicNameTiket" value="COUNTRY BUSINESS/GIMA/TRANSFERS" hidden>-->
                                <!--<input name="topicId" value="181570" hidden>-->
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>

            <div v-if="key == 'sopraInGica' && list.length > 0">
                <div class="col-md-12">
                    <table style="margin-bottom: 0" class="table table-bordered table-striped">
                        <tbody>
                        <tr>
                            <th class="col-md-2">Тикет</th>
                            <th class="col-md-6">SOPRA in GICA</th>
                            <th class="col-md-4">Действие</th>
                        </tr>
                        </tbody>
                    </table>
                    <form v-bind:id="problem" method="post" v-for="(problem, index) in list">
                        <table style="margin-bottom: 0" class="table table-bordered table-hover">
                            <tbody>
                            <tr>
                                <!--Визульная часть-->
                                <td class="col-md-2" v-model="tiketNumbers" v-bind:id="problem + '_tiket'">
                                    <button v-bind:id="problem + '_create'" type="button" class="btn btn-success btn-xs"
                                            @click="crateTiket(problem)">
                                        Создать
                                    </button>
                                    <select v-bind:id="problem + '_cimPriority'" name="cimPriority">
                                        <option value="1">Critical 1</option>
                                        <option value="2" selected>High 2</option>
                                    </select>
                                    <span v-bind:id="problem + '_number'"></span>
                                </td>
                                <td class="col-md-6">{{ problem }}</td>
                                <td class="col-md-4">Если ЖИКА не доступна - Critical 1 и звонок</td>

                                <!--Скратая часть - отправка формы с параметрами-->
                                <input name="title" v-bind:value="problem" hidden>
                                <input name="textTiket" v-bind:value="'SOPRA in GICA<br>' + problem" hidden>
                                <input name="nameGroup" value="RUS L2 - Helpdesk" hidden>
                                <input name="citName" value="999R - Multiple Sites Russia" hidden>
                                <input name="citId" value="3680" hidden>
                                <!--<input name="cimPriority" value="1" hidden>-->
                                <input name="typeTiket" value="Incident" hidden>
                                <input name="topicNameTiket" value="TECHNICAL/AS400_NPI/APPLICATION" hidden>
                                <input name="topicId" value="181902" hidden>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                lists: null,
                // сообщение Ошибка
                errorDailyStatusHd: false,
                // масив с тикетами
                tiketNumbers: [],
            }
        },
        methods: {
            // отправляем фал на сервер
            uploadFiles() {
                let app = this;
                // ищем кнопку загрузки файла
                let buttonSubmit = document.getElementById('buttonSubmit');
                // дисейблем кнопку пока идёт выгрузка
                buttonSubmit.disabled = true;
                // ищем форму
                let form = document.getElementById('uploadForm');
                // записываем форму в Дату
                let formData = new FormData(form);
                // ищем импут с фалом
                let rtfFile = document.getElementById('upload');
                // добавляем файл в Дату
                formData.append('file', rtfFile.file);
                // прячим блок Ошибка
                app.errorDailyStatusHd = false;

                // отправляем аякс запрос
                axios.post('/daily-status-helpdesk/result', formData)
                // если всё ок
                    .then(function (response) {
                        // добавляем в список проблем полученные даннеы о проблемах
                        app.lists = response.data;
                        // разблокируем кнопку отправки файла
                        buttonSubmit.disabled = false;
                    })
                    // если ошибка
                    .catch(function (error) {
                        // выводим подробности в консоль
                        console.log(error.response);
                        // разблокируем кнопку отправки файла
                        buttonSubmit.disabled = false;
                        // показываем текс Ошибка
                        app.errorDailyStatusHd = true;
                    });
            },
            // создаём тикет
            crateTiket(problem) {
                let app = this;
                // ищем каждую форму отправки
                let form = document.getElementById(problem);
                // ищем каждый спан куда вставить номер тикета
                let tiketNumber = document.getElementById(problem + '_number');
                // ищем каждую кнопку отправки
                let buttonCreate = document.getElementById(problem + '_create');
                // ищем поле в таблице где находится кнопка
                let tiket = document.getElementById(problem + '_tiket');
                // ищем поле в таблице где находится выставление приоритета
                let cimPrioritySelect = document.getElementById(problem + '_cimPriority');
                // после нажатия кнопки Создать меняем текст
                buttonCreate.innerHTML = 'Ожидайте...';
                // удаляем выбор приоритета
                tiket.removeChild(cimPrioritySelect);
                // блокируем повторное нажатие кнопки
                buttonCreate.disabled = true;
                // передаём форму в ФормДату
                let formData = new FormData(form);

                // отправляем аякс запрос
                axios.post('/athena', formData)
                // если всё ок
                    .then(function (response) {
                        // удаляем кнопку
                        tiket.removeChild(buttonCreate);
                        // ставляем номер тикета в поле span
                        tiketNumber.innerHTML = response.data;
                        // добавляем тикеты в массив
                        app.tiketNumbers.push(response.data);
                        // выводим в консоль
//                        console.log(response.data);
                    })
                    // если ошибка
                    .catch(function (error) {
                        // удаляем кнопку
                        tiket.removeChild(buttonCreate);
                        // вместо номера втавляем тест с ошибкой
                        tiketNumber.innerHTML = 'Ошибка :-(';
                        // выводим в консоль
                        console.log(error.response);
                    });
            },
            // создаём дату текущего дня в формате ДД.ММ.ГГ
            createDate() {
                // создаем дату
                let date = new Date();
                // получаем день
                let dd = date.getDate();
                if (dd < 10) dd = '0' + dd;
                // получаем месяц
                let mm = date.getMonth() + 1;
                if (mm < 10) mm = '0' + mm;
                // получаем год
                let yy = date.getFullYear() % 100;
                if (yy < 10) yy = '0' + yy;
                // формируем строку в формате ДД.ММ.ГГ
                return dd + '.' + mm + '.' + yy;
            },
            // делаем из массива с проблемными ситами в сроку через запятую
            citesList(cites) {
                return cites.join(', ');
            },
            // создаём текст тикета
            crateText(problem, cites) {
                return this.createDate() + ' <br>' + problem + ': ' + ' <br>' + this.citesList(cites);
            },
        },
        computed: {},
    }
</script>
