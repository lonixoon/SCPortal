<template>
    <div>
        <div class="form-group">
            <router-link :to="{name: 'dailyStatusPortal'}">Daily Status Portal</router-link>
            <p>
                Выгрузка ситов по которым нет данных и закрытых ситов в виде Сит - Статус<br>
                Выгрузка отчёта по витринам которые имеют статус ОШИБКА в виде Витрина - Статус
            </p>
        </div>
        <div class="form-group">
            <router-link :to="{name: 'dailyStatusHD'}">Daily Status Helpdesk</router-link>
            <p>Разбор файла Daily Status HelpDesk по активностям (проблемам) в виде Проблема - Ситы</p>
        </div>
    </div>
</template>
