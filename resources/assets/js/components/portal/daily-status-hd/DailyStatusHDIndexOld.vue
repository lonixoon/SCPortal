<template>
		<div>
				<!--<router-link to="/" class="btn btn-default">Назад</router-link>-->
				<div class="col-md-12 form-group">
						<p>Поддержка прекращена</p>
				</div>
				<div class="row">
						<form class="col-md-3" id="uploadForm" name="uploadForm" enctype="multipart/form-data">
								<!--{{ csrf_field() }}-->
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
								<table class="table table-bordered table-striped">
										<thead>
										<tr>
												<th></th>
												<th class="col-md-3">Проблема</th>
												<th>Ситы</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="(cites, problem) in listProblem">
												<td style="width: 30px"><input type="checkbox"></td>
												<td class="col-md-3">{{ problem }}</td>
												<td>{{ cites.join(', ') }}</td>
										</tr>
										</tbody>
								</table>
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
        }
    }
</script>
