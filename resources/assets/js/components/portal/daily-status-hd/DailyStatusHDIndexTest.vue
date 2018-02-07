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
												<th class="col-md-1">Тикет</th>
												<th class="col-md-3">Проблема</th>
												<th class="col-md-8">Ситы</th>
										</tr>
										</tbody>
								</table>
								<form action="" v-for="(cites, problem) in listProblem">
										<table style="margin-bottom: 0" class="table table-bordered table-striped">
												<tbody>
												<tr>
														<td class="col-md-1">
																<button type="button" class="btn btn-success btn-xs">Создать</button>
														</td>
														<td class="col-md-3">{{ problem }}</td>
														<td class="col-md-8"><span v-for="cite in cites">{{ cite }}, </span></td>
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
            crateTiket() {
                let app = this;
            },

        }
    }
</script>
