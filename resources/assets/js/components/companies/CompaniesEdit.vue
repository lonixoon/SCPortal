
<template>
    <div>
        <div class="form-group">
            <router-link to="/" class="btn btn-default">Назад</router-link>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">Редактировать компании</div>
            <div class="panel-body">
                <form v-on:submit="saveForm()">
                    <div class="row">
                        <div class="col-xs-12 form-group">
                            <label class="control-label">Имя компании</label>
                            <input type="text" v-model="company.name" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 form-group">
                            <label class="control-label">Адрес компании</label>
                            <input type="text" v-model="company.address" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 form-group">
                            <label class="control-label">Сайт компании</label>
                            <input type="text" v-model="company.website" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 form-group">
                            <label class="control-label">Почта компании</label>
                            <input type="text" v-model="company.email" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 form-group">
                            <button class="btn btn-success">Сохранить</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            let app = this;
            let id = app.$route.params.id;
            app.companyId = id;
            axios.get('/api/v1/companies/' + id)
                .then(function (resp) {
                    app.company = resp.data;
                })
                .catch(function () {
                    alert("Could not load your company")
                });
        },
        data: function () {
            return {
                companyId: null,
                company: {
                    name: '',
                    address: '',
                    website: '',
                    email: '',
                }
            }
        },
        methods: {
            saveForm() {
                var app = this;
                var newCompany = app.company;
                axios.patch('/api/v1/companies/' + app.companyId, newCompany)
                    .then(function (resp) {
                        app.$router.replace('/');
                    })
                    .catch(function (resp) {
                        console.log(resp);
                        alert("Could not create your company");
                    });
            }
        }
    }
</script>
