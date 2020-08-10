import Vue from 'vue';
import InputText from 'primevue/inputtext';
import Button from 'primevue/button';
import Ripple from 'primevue/ripple';
import Toast from 'primevue/toast';
import ToastService from 'primevue/toastservice';

Vue.directive('ripple', Ripple);

Vue.use(ToastService);

Vue.component('InputText', InputText);
Vue.component('Button', Button);
Vue.component('Toast', Toast);

export default (_context, inject) => {
    inject('primevue', { ripple: true })
}
