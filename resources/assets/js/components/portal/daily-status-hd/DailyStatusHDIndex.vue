<template>
    <div>
        <router-link to="/" class="btn btn-default">Назад</router-link>
        <div class="col-md-12 form-group">
            <h3>Разбор файла Daily Status HelpDesk по активностям (проблемам)</h3>
        </div>
        <div class="row">
            <form class="col-md-3" id="uploadForm" name="uploadForm" enctype="multipart/form-data">
                <!--{{ csrf_field() }}-->
                <div class="form-group">
                    <input class="btn btn-default"  type='file' accept='.rtf' name='file' id='upload' required>
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-primary" @click="this.uploadFiles">Загрузить</button>
                </div>
            </form>
        </div>
        <div class="row col-md-6" v-for="listProblem in list" >
            <div class="alert alert-info" v-for="(cites, problem) in listProblem" >
                <div>{{ problem }} <input type="checkbox"></div>
                <span v-for="cite in cites">{{ cite }}, </span>
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
                let app = this;
                let formData = new FormData(document.getElementById('uploadForm'));
                let rtfFile = document.getElementById('upload');
//                console.log(rtfFile.file);
                formData.append('file', rtfFile.file);
                axios.post('http://scportal/daily-status-helpdesk/result', formData)
                    .then(function (response) {
                        app.list = response.data;
//                        console.log(resp);
                    })
                    .catch(error => {
                        console.log(error.response);
                    })
            }
        }
    }
</script>
