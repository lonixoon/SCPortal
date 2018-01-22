<template>
    <div>
        <!--<router-link to="/" class="btn btn-default">Назад</router-link>-->
        <div class="col-md-12 form-group">
            <h3>Daily Status Portal</h3>
        </div>
        <div class="row">
            <div class="col-md-6">
                <h4>Портал Классика</h4>
                <div class="form-group">
                    <button id="buttonClassic" type="button" class="btn btn-primary" @click="this.portalClassicUpload">Запустить выгрузку</button>
                </div>
                <div v-show="loadingClassic" class="alert alert-info text-center">
                    Идёт загрузка...
                </div>
                <table class="table table-bordered table-striped"  v-for="portalClassic in classic">
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

            <div class="col-md-6">
                <h4>Портал АТАК</h4>
                <div class="form-group">
                    <button id="buttonAtak" type="button" class="btn btn-primary" @click="this.portalAtakUpload">Запустить выгрузку</button>
                </div>
                <div v-show="loadingAtak" class="alert alert-info text-center">
                    Идёт загрузка...<br> С Порталом АТАК бывают сложности, если появится ошибка, запустите выгрузку ещё раз...
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
        </div>
    </div>
</template>

<script>
    export default {
        data: function () {
            return {
                classic: [],
                atak: [],
                loadingClassic: false,
                loadingAtak: false,
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
                        buttonClassic.disabled = false;
                        alert("Не удалось загрузить данные КЛАССИКИ");
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
                        buttonAtak.disabled = false;
                        alert("Не удалось загрузить данные АТАК");
                    });
            },
        }
    }
</script>