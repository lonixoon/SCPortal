<template>
		<div>
				<!--<router-link to="/" class="btn btn-default">Назад</router-link>-->
				<div class="col-md-12 form-group">
						<h3>Тестовый Daily Status HelpDesk</h3>
						<p>Тестируем написание тикетов из дейлика</p>
				</div>
				<div class="row">
						<form class="col-md-3" id="uploadForm" name="uploadForm" enctype="multipart/form-data">
								<div class="form-group">
										<input class="btn btn-default" type='file' accept='.rtf' name='file' id='upload' required>
								</div>
								<div class="form-group">
										<button id="buttonSubmit" type="button" class="btn btn-primary" @click="this.uploadFiles">
												Загрузить
										</button>
								</div>
						</form>
				</div>
				<div class="row" v-for="listProblem in list">

						<div class="col-md-12">
								<table style="margin-bottom: 0" class="table table-bordered table-striped">
										<tbody>
										<tr>
												<th class="col-md-2">Тикет</th>
												<th class="col-md-3">Проблема</th>
												<th class="col-md-7">Ситы</th>
										</tr>
										</tbody>
								</table>
								<form v-bind:id="problem" method="post" v-for="(cites, problem) in listProblem">
										<table style="margin-bottom: 0" class="table table-bordered table-striped">
												<tbody>
												<tr>
														<td class="col-md-2" v-bind:id="problem + '_tiket'">
																<button v-bind:id="problem + '_create'" type="button" class="btn btn-success btn-xs" @click="crateTiket(problem)">
																		Создать
																</button>
																<!--<span v-bind:id="problem + '_load'">Ожидайте...</span>-->
																<!--<span v-bind:id="problem + '_error'">Ошибка</span>-->
																<span v-bind:id="problem + '_number'"></span>
														</td>
														<td class="col-md-3">{{ problem }}</td>
														<td class="col-md-7">{{ cites.join(', ') }}</td>
														<input name="title" v-bind:value="problem" hidden>
														<input name="textTiket" v-bind:value="problem + ': ' + cites.join(', ')" hidden>
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
                list: [],
            }
        },
        methods: {
            uploadFiles() {
                // дисейблем кнопку пока идёт выгрузка
                let buttonSubmit = document.getElementById('buttonSubmit');
                buttonSubmit.disabled = true;

                let app = this;
                let formData = new FormData(document.getElementById('uploadForm'));
                let rtfFile = document.getElementById('upload');
                formData.append('file', rtfFile.file);
                axios.post('/daily-status-helpdesk/result', formData)
                    .then(function (response) {
                        app.list = response.data;
                        buttonSubmit.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        buttonSubmit.disabled = false;
                        alert("Не удалось обработать данные");
                    });
            },
            crateTiket(problem) {
                let app = this;
                let form = document.getElementById(problem);
                let tiketNumber = document.getElementById(problem + '_number');
                let buttonCreate = document.getElementById(problem + '_create');
                let tiket = document.getElementById(problem + '_tiket');
                buttonCreate.innerHTML = 'Идёт загрузка';
                buttonCreate.disabled = true;
                let formData = new FormData(form);

                axios.post('/athena', formData)
                    .then(function (response) {
                        console.log(response.data);
                        tiketNumber.innerHTML = response.data;
                        tiket.removeChild(buttonCreate);
                    })
                    .catch(function (error) {
                        console.log(error.response);
                    });
            },

        }
    }
</script>
