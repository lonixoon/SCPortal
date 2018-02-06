<template>
		<div>
				<!--<router-link to="/" class="btn btn-default">Назад</router-link>-->
				<div class="col-md-12 form-group">
						<h3>Daily Status Portal</h3>
						<!--<div class="alert alert-warning">-->
						<!--<p>На стадии тестирования, рекомендуем дважды запускать отчёт Портал Классика и Портал АТАК для-->
						<!--перепроверки. Т.к. если сервер Портала	будет тупить, то данные могут быть не корректные.-->
						<!--</p>-->
						<!--<p>-->
						<!--Выгрузки запускается асинхронно, отчёты можно запускать в любой последовательности или все сразу.-->
						<!--</p>-->
						<!--</div>-->
						<div class="col-md-5 alert alert-info">
								<p>Ситы по которым нет данных (No data) и закрытые ситы (Closed).</p>
								<p>Перезапустите отчёт хотя бы один раз, что бы проверить корректность данных.</p>
						</div>
						<div class="col-md-2">
								<div class="form-group">
										<button id="buttonAllReport" type="button" class="btn btn-success center-block"
														@click="this.allReport">
												Запустить выгрузку<br> всех отчётов
										</button>
								</div>
						</div>
						<div class="col-md-5 alert alert-info">
								<p>Витрины со статусом ОШИБКА, за период с 18:00 предыдущего дня по 23:59 текущего дня.</p>
								<p>Если витрина была в ОШИБКЕ, но текущей её статус НОРМАЛЬНО, в отчёте её не будет.</p>
						</div>
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
								<div v-show="errorClassic" class="alert alert-danger text-center">
										Не удалось загрузить данные Классики
								</div>
								<!--<div v-show="errorClassic" class="alert text-center hellfire">-->
								<!--<span class="hellfire__span">Не удалось загрузить данные КЛАССИКИ</span>-->
								<!--</div>-->
								<table class="table table-bordered table-striped" v-for="portalClassic in classic">
										<thead>
										<tr>
												<th class="col-md-7">Ситы</th>
												<th class="col-md-5">Статус</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="(statusClassic, citeClassic) in portalClassic">
												<td v-if="statusClassic == 'No data'" class="danger">{{ citeClassic }}</td>
												<td v-if="statusClassic == 'No data'" class="danger">{{ statusClassic }}</td>
												<td v-if="statusClassic != 'No data'" class="warning">{{ citeClassic }}</td>
												<td v-if="statusClassic != 'No data'" class="warning">{{ statusClassic }}</td>
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
										Идёт загрузка...
								</div>
								<div v-show="errorAtak" class="alert alert-danger text-center">
										Не удалось загрузить данные Атак
								</div>
								<!--<div v-show="errorAtak" class="alert text-center hellfire">-->
								<!--<span class="hellfire__span">Не удалось загрузить данные АТАК</span>-->
								<!--</div>-->
								<table class="table table-bordered table-striped" v-for="portalAtak in atak">
										<thead>
										<tr>
												<th class="col-md-7">Ситы</th>
												<th class="col-md-5">Статус</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="(statusAtak, citeAtak) in portalAtak">
												<td v-if="statusAtak == 'No data'" class="danger">{{ citeAtak }}</td>
												<td v-if="statusAtak == 'No data'" class="danger">{{ statusAtak }}</td>
												<td v-else="statusAtak != 'No data'" class="warning">{{ citeAtak }}</td>
												<td v-if="statusAtak != 'No data'" class="warning">{{ statusAtak }}</td>
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
								<div v-show="errorAdminClassic" class="alert alert-danger text-center">
										Не удалось загрузить данные витрин Классики
								</div>
								<table class="table table-bordered table-striped" v-for="value in showcaseNamesClassic">
										<thead>
										<tr>
												<th class="">Витрина</th>
												<th class="">Статус</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="(status, showcaseNameClassic) in value">
												<td class="danger">{{ showcaseNameClassic }}</td>
												<td class="danger">{{ status }}</td>
										</tr>
										<tr>
												<td v-show="successAdminClassic" colspan="2" class="text-center success">
														Ура! Все витрины имеют статус НОРМАЛЬНО.
												</td>
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
								<div v-show="errorAdminAtak" class="alert alert-danger text-center">
										Не удалось загрузить данные витрин АТАК
								</div>
								<table class="table table-bordered table-striped" v-for="value in showcaseNamesAtak">
										<thead>
										<tr>
												<th class="">Витрина</th>
												<th class="">Статус</th>
										</tr>
										</thead>
										<tbody>
										<tr v-for="(status, showcaseNameAtak) in value">
												<td class="danger">{{ showcaseNameAtak }}</td>
												<td class="danger">{{ status }}</td>
										</tr>
										<tr>
												<td v-show="successAdminAtak" colspan="2" class="text-center success">
														Ура! Все витрины имеют статус НОРМАЛЬНО.
												</td>
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

                successAdminAtak: false,
                successAdminClassic: false,
            }
        },
        // запусть функции после отрисовки страницы
//        mounted() {
//            this.portalClassicUpload();
//            this.portalAtakUpload();
//        },
        methods: {
						/*
						 Запуск всех отчётов сразу
						 */
            allReport() {
                // ищём кнопку "Запустить выгрузку всех очётов"
                let buttonAllReport = document.getElementById('buttonAllReport');
                // бликируем кнопку "Запустить выгрузку всех очётов"
                buttonAllReport.disabled = true;
                // запускаем все функции разом
                this.portalClassicUpload();
                this.portalAtakUpload();
                this.portalAdminClassicUpload();
                this.portalAdminAtakUpload();
                // разблокируем кнопку "Запустить выгрузку всех очётов" через время
                setTimeout(function () {
                    buttonAllReport.disabled = false;
                }, 30000);
            },

						/*
						 Выгрузка данных по Портал Калассика
						 */
            portalClassicUpload() {
                // ищем кнопку 'запустить выгрузку'
                let buttonClassic = document.getElementById('buttonClassic');
                // блокируем кнопку 'запустить выгрузку'
                buttonClassic.disabled = true;

                let app = this;
                // показывем 'загрузка' пока выгружаются данные
                app.loadingClassic = true;
                // скрваем результаты на время выгрузки
                app.classic = [];
                // делаем запрос данные по указанному адресу
                axios.get('/daily-status-portal/portal-classic')
                // если данные получены
                    .then(function (resp) {
                        // выводим полученные данные
                        app.classic = resp.data;
                        // прячем блок 'загрузка...'
                        app.loadingClassic = false;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonClassic.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        // прячем блок 'загрузка...'
                        app.loadingClassic = false;
                        // показываем блок "ошибка"
                        app.errorClassic = true;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonClassic.disabled = false;
                    });
            },
            portalAtakUpload() {
                // дисейблем кнопку пока идёт выгрузка
                let buttonAtak = document.getElementById('buttonAtak');
                // блокируем кнопку 'запустить выгрузку'
                buttonAtak.disabled = true;

                let app = this;
                // показывем 'загрузка' пока выгружаются данные
                app.loadingAtak = true;
                // скрваем результаты на время выгрузки
                app.atak = [];
                // делаем запрос данные по указанному адресу
                axios.get('/daily-status-portal/portal-atak')
                // если данные получены
                    .then(function (resp) {
                        // выводим полученные данные
                        app.atak = resp.data;
                        // прячем блок 'загрузка...'
                        app.loadingAtak = false;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonAtak.disabled = false;
                    })
                    .catch(function (error) {
                        console.log(error.response);
                        // прячем блок 'загрузка...'
                        app.loadingAtak = false;
                        // показываем блок "ошибка"
                        app.errorAtak = true;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonAtak.disabled = false;
                    });
            },

						/*
						 Выгрузка данных Портал Админ Классика
						 */
            portalAdminClassicUpload() {
                // ищем кнопку 'запустить выгрузку'
                let buttonAdminClassic = document.getElementById('buttonAdminClassic');
                // блокируем кнопку 'запустить выгрузку'
                buttonAdminClassic.disabled = true;

                let app = this;
                // показывем 'загрузка' пока выгружаются данные
                app.loadingAdminClassic = true;
								// скрваем результаты на время выгрузки
                app.showcaseNamesClassic = [];
                // делаем запрос данные по указанному адресу
                axios.get('/daily-status-admin-portal/portal-classic')
                // если данные получены
                    .then(function (resp) {
                        // выводим полученные данные
                        app.showcaseNamesClassic = resp.data;
                        // прячем блок 'загрузка...'
                        app.loadingAdminClassic = false;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonAdminClassic.disabled = false;
                        // если ошибок нет, показываем сообщение
                        if (app.showcaseNamesClassic['lists'].length <= 0) {
                            app.successAdminClassic = true;
                        }
                    })
                    // если произошла ошибка
                    .catch(function (error) {
                        // выводим полный текст в консоль
                        console.log(error.response);
                        // прячем блок 'загрузка...'
                        app.loadingAdminClassic = false;
                        // показываем блок "ошибка"
                        app.errorAdminClassic = true;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonAdminClassic.disabled = false;
                    });
            },

						/*
						 Выгрузка данных Портал Админ АТАК
						 */
            portalAdminAtakUpload() {
                // ищем кнопку 'запустить выгрузку'
                let buttonAdminAtak = document.getElementById('buttonAdminAtak');
                // блокируем кнопку 'запустить выгрузку'
                buttonAdminAtak.disabled = true;

                let app = this;
                // показывем 'загрузка' пока выгружаются данные
                app.loadingAdminAtak = true;
                // скрваем результаты на время выгрузки
                app.showcaseNamesAtak = [];
                // делаем запрос данные по указанному адресу
                axios.get('/daily-status-admin-portal/portal-atak')
                // если данные получены
                    .then(function (resp) {
                        // выводим полученные данные
                        app.showcaseNamesAtak = resp.data;
                        // прячем блок 'загрузка...'
                        app.loadingAdminAtak = false;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonAdminAtak.disabled = false;
                        // если ошибок нет, показываем сообщение
                        if (app.showcaseNamesAtak['lists'].length <= 0) {
                            app.successAdminAtak = true;
                        }
                    })
                    // если произошла ошибка
                    .catch(function (error) {
                        // выводим полный текст в консоль
                        console.log(error.response);
                        // прячем блок 'загрузка...'
                        app.loadingAdminAtak = false;
                        // показываем блок "ошибка"
                        app.errorAdminAtak = true;
                        // разблокируем кнопку 'запустить выгрузку'
                        buttonAdminAtak.disabled = false;
                    });
            },
        }
    }
</script>