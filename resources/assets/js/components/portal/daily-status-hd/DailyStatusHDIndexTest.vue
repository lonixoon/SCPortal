<template>
    <div>
        <!--<router-link to="/" class="btn btn-default">Назад</router-link>-->
        <div class="col-md-12 form-group">
            <h3>Разбор файла Daily Status HelpDesk по активностям (проблемам)</h3>
            <div class="alert alert-info">
                <p>Добавлена отправка тикетов на ХД</p>
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
            <form class="col-md-3" id="uploadForm" name="uploadForm" enctype="multipart/form-data">
                <div class="form-group">
                    <input class="btn btn-default" type='file' accept='.rtf' name='file' id='upload' required>
                </div>
                <div class="form-group">
                    <!--<button id="buttonSubmit" type="button" class="btn btn-primary" @click="this.uploadFiles">-->
                    <button id="buttonSubmit" type="button" class="btn btn-primary" @click="uploadFiles">
                        Загрузить
                    </button>
                </div>
            </form>
        </div>
        <div v-show="errorDailyStatusHd" class="alert alert-danger">Не удалось обработать данные</div>
        <div class="row">

            <div class="col-md-12">
                <table v-if="list !== null" style="margin-bottom: 0" class="table table-bordered table-striped">
                    <tbody>
                    <tr>
                        <th class="col-md-2">Тикет</th>
                        <th class="col-md-3">Проблема</th>
                        <th class="col-md-7">Ситы</th>
                    </tr>
                    </tbody>
                </table>
                <form v-bind:id="problem" method="post" v-for="(cites, problem) in list">
                    <table style="margin-bottom: 0" class="table table-bordered table-striped">
                        <tbody>
                        <tr>
                            <!--Визульная часть-->
                            <td class="col-md-2" v-bind:id="problem + '_tiket'">
                                <button v-bind:id="problem + '_create'" type="button" class="btn btn-success btn-xs"
                                        @click="crateTiket(problem)">
                                    Создать
                                </button>
                                <span v-bind:id="problem + '_number'"></span>
                            </td>
                            <td class="col-md-3">{{ problem }}</td>
                            <td class="col-md-7">{{ cites.join(', ') }}</td>

                            <!--Отправка формы с параметрами-->
                            <input name="title" v-bind:value="problem" hidden>
                            <input name="textTiket" v-bind:value="createDate() + ' <br>' + problem
														 + ': ' + ' <br>' +  cites.join(', ')" hidden>
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
    </div>
</template>

<script>
    export default {
        data() {
            return {
                list: null,
                errorDailyStatusHd: false,
            }
        },
        methods: {
            uploadFiles() {
                let app = this;
                // дисейблем кнопку пока идёт выгрузка
                let buttonSubmit = document.getElementById('buttonSubmit');
                buttonSubmit.disabled = true;
                let formData = new FormData(document.getElementById('uploadForm'));
                let rtfFile = document.getElementById('upload');
                formData.append('file', rtfFile.file);
                app.errorDailyStatusHd = false;


                axios.post('/daily-status-helpdesk/result', formData)
                    .then(function (response) {
                        app.list = response.data;
                        buttonSubmit.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        buttonSubmit.disabled = false;
                        app.errorDailyStatusHd = true;
                    });
            },
            crateTiket(problem) {
                let app = this;
                let form = document.getElementById(problem);
                let tiketNumber = document.getElementById(problem + '_number');
                let buttonCreate = document.getElementById(problem + '_create');
                let tiket = document.getElementById(problem + '_tiket');
                buttonCreate.innerHTML = 'Ожидайте...';
                buttonCreate.disabled = true;
                let formData = new FormData(form);

                axios.post('/athena', formData)
                    .then(function (response) {
                        tiketNumber.innerHTML = response.data;
                        tiket.removeChild(buttonCreate);
                        console.log(response.data);
                    })
                    .catch(function (error) {
                        tiketNumber.innerHTML = 'Ошибка :-(';
                        tiket.removeChild(buttonCreate);
                        console.log(error.response);
                    });
            },
            createDate() {
                let date = new Date();

                let dd = date.getDate();
                if (dd < 10) dd = '0' + dd;

                let mm = date.getMonth() + 1;
                if (mm < 10) mm = '0' + mm;

                let yy = date.getFullYear() % 100;
                if (yy < 10) yy = '0' + yy;

                return dd + '.' + mm + '.' + yy;
            },
        },
    }
</script>
