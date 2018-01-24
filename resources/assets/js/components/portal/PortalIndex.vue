<template>
    <div>
        <div class="form-group">
            <router-link :to="{name: 'dailyStatusPortal'}">Daily Status Portal</router-link>
            <p>
                Выгрузка ситов по которым нет данных и закрытых ситов<br>
                Выгрузка витрин со статусом ОШИБКА
            </p>
        </div>
        <div class="form-group">
            <router-link :to="{name: 'dailyStatusHD'}">Daily Status Helpdesk</router-link>
            <p>Разбор файла Daily Status HelpDesk по активностям (проблемам)</p>
        </div>
    </div>
</template>
