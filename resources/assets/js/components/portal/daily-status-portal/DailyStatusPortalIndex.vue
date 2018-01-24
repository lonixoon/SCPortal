<template>
		<div>
				<!--<router-link to="/" class="btn btn-default">Назад</router-link>-->
				<div class="col-md-12 form-group">
						<h3>Daily Status Portal</h3>
						<div class="alert alert-warning">
								На стадии тестирования, рекомендуем дважды запускать отчёт Портал Классика и Портал АТАК для
								перепроверки. Т.к. если сервер Портала	будет тупить, то данные могут быть не корректные.
						</div>
						<div class="alert alert-warning">
								Выгрузки запускается асинхронно, по этому, не нужно ждать пока загрузятся данные по одному отчёту. Можно тыкнуть на все четыре кнопки сразу!
						</div>
						<!--<div class="row">-->
						<div class="col-md-5 alert alert-success">
								Выгружает ситы по которым нет данных (No data) и закрытые ситы (Closed).
						</div>
						<div class="col-md-5 col-md-offset-1 alert alert-info">
								Выгружает название витрин со статусом ОШИБКА за период с 18:00 предыдущего дня по 23:59
								текущего дня. Если пусто, всё ок!  :-)
						</div>
						<!--</div>-->
				</div>
				<div class="row">

						<div class="col-md-3">
								<h4>Портал Классика</h4>
								<div class="form-group">
										<button id="buttonClassic" type="button" class="btn btn-primary" @click="this.portalClassicUpload">
												Запустить выгрузку
										</button>
								</div>
								<div v-show="loadingClassic" class="alert alert-info text-center">
										Идёт загрузка...
								</div>
								<!--<div v-show="errorClassic" class="alert alert-danger text-center">-->
										<!--Не удалось загрузить данные КЛАССИКИ-->
								<!--</div>-->
								<div v-show="errorClassic" class="alert text-center hellfire">
										<span class="hellfire__span">Не удалось загрузить данные КЛАССИКИ</span>
								</div>
								<table class="table table-bordered table-striped" v-for="portalClassic in classic">
										<thead>
										<tr>
												<th class="col-md-7">Ситы</th>
												<th class="col-md-5">Статус</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="(statusClassic, citeClassic) in portalClassic">
												<td>{{ citeClassic }}</td>
												<td>{{ statusClassic }}</td>
										</tr>
										</tbody>
								</table>
						</div>

						<div class="col-md-3">
								<h4>Портал АТАК</h4>
								<div class="form-group">
										<button id="buttonAtak" type="button" class="btn btn-primary" @click="this.portalAtakUpload">
												Запустить выгрузку
										</button>
								</div>
								<div v-show="loadingAtak" class="alert alert-info text-center">
										Идёт загрузка...<br>
										С Порталом АТАК бывают сложности, если появится ошибка, запустите выгрузку ещё раз...
								</div>
								<!--<div v-show="errorAtak" class="alert alert-danger text-center">-->
										<!--Не удалось загрузить данные АТАК-->
								<!--</div>-->
								<div v-show="errorAtak" class="alert text-center hellfire">
										<span class="hellfire__span">Не удалось загрузить данные АТАК</span>
								</div>
								<table class="table table-bordered table-striped" v-for="portalAtak in atak">
										<thead>
										<tr>
												<th class="col-md-7">Ситы</th>
												<th class="col-md-5">Статус</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="(statusAtak, citeAtak) in portalAtak">
												<td>{{ citeAtak }}</td>
												<td>{{ statusAtak }}</td>
										</tr>
										</tbody>
								</table>
						</div>

						<div class="col-md-3">
								<h4>Портал Админ Классика</h4>
								<div class="form-group">
										<button id="buttonAdminClassic" type="button" class="btn btn-primary"
														@click="this.portalAdminClassicUpload">Запустить выгрузку
										</button>
								</div>
								<div v-show="loadingAdminClassic" class="alert alert-info text-center">
										Идёт загрузка...
								</div>
								<!--<div v-show="errorAdminClassic" class="alert alert-danger text-center">-->
										<!--Не удалось загрузить данные витрин Классики-->
								<!--</div>-->
								<div v-show="errorAdminClassic" class="alert text-center hellfire">
										<span class="hellfire__span">Не удалось загрузить данные витрин Классики</span>
								</div>
								<table class="table table-bordered table-striped" v-for="showcaseNameClassic in showcaseNamesClassic">
										<thead>
										<tr>
												<th class="">Витрина со статусом ОШИБКА</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="showcaseClassic in showcaseNameClassic">
												<td>{{ showcaseClassic }}</td>
										</tr>
										</tbody>
								</table>
						</div>

						<div class="col-md-3">
								<h4>Портал Админ АТАК</h4>
								<div class="form-group">
										<button id="buttonAdminAtak" type="button" class="btn btn-primary"
														@click="this.portalAdminAtakUpload">Запустить выгрузку
										</button>
								</div>
								<div v-show="loadingAdminAtak" class="alert alert-info text-center">
										Идёт загрузка...
								</div>
								<!--<div v-show="errorAdminAtak" class="alert alert-danger text-center">-->
										<!--Не удалось загрузить данные витрин АТАК-->
								<!--</div>-->
								<div v-show="errorAdminAtak" class="alert text-center hellfire">
										<span class="hellfire__span">Не удалось загрузить данные витрин АТАК</span>
								</div>
								<table class="table table-bordered table-striped" v-for="showcaseNameAtak in showcaseNamesAtak">
										<thead>
										<tr>
												<th class="">Витрина со статусом ОШИБКА</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="showcaseAtak in showcaseNameAtak">
												<td>{{ showcaseAtak }}</td>
										</tr>
										</tbody>
								</table>
						</div>

				</div>
		</div>
</template>

<script>
    export default {
        data: function () {
            return {
                classic: [],
                atak: [],
                showcaseNamesClassic: [],
                showcaseNamesAtak: [],

                loadingClassic: false,
                loadingAtak: false,
                loadingAdminClassic: false,
                loadingAdminAtak: false,

                errorClassic: false,
                errorAtak: false,
                errorAdminClassic: false,
								errorAdminAtak: false,
            }
        },
        // запусть функции после отрисовки страницы
//        mounted() {
//            this.portalClassicUpload();
//            this.portalAtakUpload();
//        },
        methods: {
            portalClassicUpload() {
                // дисейблем кнопку пока идёт выгрузка
                let buttonClassic = document.getElementById('buttonClassic');
                buttonClassic.disabled = true;

                let app = this;
                app.loadingClassic = true;
                axios.get('/daily-status-portal/api/classic')
                    .then(function (resp) {
                        app.classic = resp.data;
                        app.loadingClassic = false;
                        buttonClassic.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        app.loadingClassic = false;
                        app.errorClassic = true;
                        buttonClassic.disabled = false;
//                        alert("Не удалось загрузить данные КЛАССИКИ");
                    });
            },
            portalAtakUpload() {
                // дисейблем кнопку пока идёт выгрузка
                let buttonAtak = document.getElementById('buttonAtak');
                buttonAtak.disabled = true;

                let app = this;
                app.loadingAtak = true;
                axios.get('/daily-status-portal/api/atak')
                    .then(function (resp) {
                        app.atak = resp.data;
                        app.loadingAtak = false;
                        buttonAtak.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        app.loadingAtak = false;
                        app.errorAtak = true;
                        buttonAtak.disabled = false;
//                        alert("Не удалось загрузить данные АТАК");
                    });
            },
            portalAdminClassicUpload() {
                let buttonAdminClassic = document.getElementById('buttonAdminClassic');
                buttonAdminClassic.disabled = true;

                let app = this;
                app.loadingAdminClassic = true;
                axios.get('/daily-status-admin-portal/portal-classic')
                    .then(function (resp) {
                        app.showcaseNamesClassic = resp.data;
                        app.loadingAdminClassic = false;
                        buttonAdminClassic.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        app.loadingAdminClassic = false;
                        app.errorAdminClassic = true;
                        buttonAdminClassic.disabled = false;
//                        alert("Не удалось загрузить данные витрин Классики");
                    });
            },
            portalAdminAtakUpload() {
                let buttonAdminAtak = document.getElementById('buttonAdminAtak');
                buttonAdminAtak.disabled = true;

                let app = this;
                app.loadingAdminAtak = true;
                axios.get('/daily-status-admin-portal/portal-atak')
                    .then(function (resp) {
                        app.showcaseNamesAtak = resp.data;
                        app.loadingAdminAtak = false;
                        buttonAdminAtak.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        app.loadingAdminAtak = false;
                        app.errorAdminAtak = true;
                        buttonAdminAtak.disabled = false;
//                        alert("Не удалось загрузить данные витрин АТАК");
                    });
            },
        }
    }
</script>