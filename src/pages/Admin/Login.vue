<template lang="pug">
  form.admin-login(@submit.prevent='submitHandler')
    h1.admin-login__title.form__title Вход в админ-панель
    email-field(id="admin-login-email" v-model="email" :v="$v.email")
    password-field(id="admin-login-password" v-model="password" :v="$v.password")
    .admin-login__action
      button-hover(tag="button" type="submit" variant="white") Войти
      router-link.admin-login__link(:to="{name: 'Forgot'}") Забыли пароль?
</template>

<script>
import { required, email, helpers } from 'vuelidate/lib/validators'
import PasswordField from '@/components/FormElements/PasswordField'
import EmailField from '@/components/FormElements/EmailField'
import { mapActions } from 'vuex'
import { authorizationIo } from '../../api/socetIO'
export default {
  name: 'AdminLogin',
  components: {
    PasswordField,
    EmailField
  },
  data: () => ({
    email: '',
    password: ''
  }),
  computed: {
    redirectUrl() {
      return this.$route.query.redirect
    },
  },
  methods: {
    ...mapActions('auth/api', ['loginAdmin']),
    ...mapActions('profile/info', ['apiInfo']),
    submitHandler() {
      if (this.$v.$invalid) {
        this.$v.$touch()
        return
      }
      this.loginAdmin({ email: this.email, password: this.password })
        .then(() => {
          this.apiInfo().then(async () => {
            await authorizationIo();
            this.$router.push({ name: this.redirectUrl || 'AdminUsers' });
          })
        })
        .catch((error) => {})
    }
  },
  validations: {
    email: { required, email },
    password: { required, checkPass: helpers.regex('password', /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8,}$/) }
  }
}
</script>

<style lang="stylus">
@import '../../assets/stylus/base/vars.styl';

.admin-login {
  width: 100%;
  max-width: 450px;
}

.admin-login__title {
  margin-bottom: 50px;
}

.admin-login__action {
  margin-top: 50px;
  display: flex;
  align-items: center;
}

.admin-login__link {
  display: block;
  margin-left: 30px;
  font-size: 13px;
  color: rgba(255, 255, 255, 0.5);
  transition: all 0.2s;

  &:hover {
    color: #fff;
  }
}
</style>
