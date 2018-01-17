<template>
	<div>
		<div>
			<h3>Портал Классика</h3>
			<table class="table table-bordered table-striped">
				<thead>
				<tr>
					<th>Ситы</th>
					<th>Статус</th>
				</tr>
				</thead>
				<tbody v-for="portalClassic in classic">
				<tr v-for="(statusClassic, citeClassic) in portalClassic">
					<td>{{ citeClassic }}</td>
					<td>{{ statusClassic }}</td>
				</tr>
				</tbody>
			</table>
		</div>

		<div>
			<h3>Портал АТАК</h3>
			<table class="table table-bordered table-striped">
				<thead>
				<tr>
					<th>Ситы</th>
					<th>Статус</th>
				</tr>
				</thead>
				<tbody v-for="portalAtak in atak">
				<tr v-for="(statusAtak, citeAtak) in portalAtak">
					<td>{{ citeAtak }}</td>
					<td>{{ statusAtak }}</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
</template>

<script>
    export default {
        data: function () {
            return {
                classic: [],
                atak: []
            }
        },
        mounted() {
            let app = this;
            axios.get('/daily-status-portal/api/classic')
                .then(function (resp) {
                    app.classic = resp.data;
                })
                .catch(function (resp) {
                    console.log(resp);
                    alert("Не удалось загрузить данные КЛАССИКИ");
                });
            axios.get('/daily-status-portal/api/atak')
                .then(function (resp) {
                    app.atak = resp.data;
                })
                .catch(function (resp) {
                    console.log(resp);
                    alert("Не удалось загрузить данные АТАК");
                });
        }
    }
</script>