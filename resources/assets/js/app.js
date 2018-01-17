
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');
import VueRouter from 'vue-router';

window.Vue.use(VueRouter);

import CompaniesIndex from './components/companies/CompaniesIndex.vue';
import CompaniesCreate from './components/companies/CompaniesCreate.vue';
import CompaniesEdit from './components/companies/CompaniesEdit.vue';

import PortalIndex from './components/portal/PortalIndex.vue';
import DailyStatusPortalIndex from './components/portal/daily-status-portal/DailyStatusPortalIndex.vue';

// const routes = [
//     {
//         path: '/',
//         components: {
//             companiesIndex: CompaniesIndex
//         }
//     },
//     {path: '/create', component: CompaniesCreate, name: 'createCompany'},
//     {path: '/edit/:id', component: CompaniesEdit, name: 'editCompany'},
// ]

const routes = [
    {
        path: '/',
        components: {
            portalIndex: PortalIndex,
            companiesIndex: CompaniesIndex
        }
    },
    {path: '/daily-status-portal', component: DailyStatusPortalIndex, name: 'dailyStatusPortal'},
    // {path: '/daily-status-hd', component: dailyStatusHD, name: 'dailyStatusHD'},

//     {
//         path: '/',
//         components: {
//             companiesIndex: CompaniesIndex
//         }
//     },
    {path: '/create', component: CompaniesCreate, name: 'createCompany'},
    {path: '/edit/:id', component: CompaniesEdit, name: 'editCompany'},
];

const router = new VueRouter({ routes });

const app = new Vue({ router }).$mount('#app');