<template lang="pug">
.form__group(:class='{ fill: password.length > 0 }')
    label.form__label(:for='id') {{ $t("repeatPassword") }}
    input.form__input(
        name='password',
        type='password',
        :id='id',
        v-model.trim='password',
        :autocomplete='autocomplete',
        @change='v.$touch()',
        :class='{ invalid: (v.$dirty && !v.required) ||  (v.$dirty && !v.sameAsPassword) }'
    )
    span.form__error(v-if='v.$dirty && !v.sameAsPassword') {{ $t("matchPassword") }}
    //span.form__error(v-if='v.$dirty && !v.checkPass') {{ $t("errorPassword3") }}
</template>

<script>
export default {
    name: 'PasswordRepeatField',
    props: {
        value: {
            type: String,
            default: '',
        },
        v: {
            type: Object,
            required: true,
        },
        id: {
            type: String,
            required: true,
        },
        autocomplete: {
            type: String,
        },
    },
    computed: {
        password: {
            get() {
                return this.value
            },
            set(value) {
                this.$emit('input', value)
            },
        },
    },
    i18n: {
        messages: {
            en: {
                repeatPassword: 'Repeat password',
                matchPassword: 'Passwords must match',
                errorPassword1: 'Password must be at least',
                errorPassword2: 'characters. He is now',
                errorPassword3: 'NO',
            },
            ru: {
                repeatPassword: 'Повторите пароль',
                matchPassword: 'Пароли должны совпадать',
                errorPassword1: 'Пароль должен быть не менее',
                errorPassword2: 'символов. Сейчас он',
                errorPassword3: 'Пароль не подходит',
            },
        },
    },
}
</script>

