<template lang="pug">
  .settings.inner-page
    h1.settings__title {{activeComponent.text}}
    .settings__wrap
      .inner-page__main
        component(:is="activeComponent.component")
      .inner-page__aside
        settings-sidebar(v-model="activeComponent.component" @change-component="onChange")
</template>

<script>
import SettingsMain from '@/components/Settings/Main'
import SettingsPush from '@/components/Settings/Push'
import SettingsSecurity from '@/components/Settings/Security'
import SettingsDelete from '@/components/Settings/Delete'
import SettingsLang from '@/components/Settings/Lang'
import SettingsSidebar from '@/components/Settings/Sidebar'
export default {
  name: 'Settings',
  components: { SettingsMain, SettingsPush, SettingsSecurity, SettingsDelete, SettingsSidebar, SettingsLang },
  data: () => ({
    activeComponent: { component: 'settings-main', text: 'Основные' }
  }),
  methods: {
    onChange(item) {
      this.activeComponent = item
    }
  },
  created() {
    if (localStorage.getItem('lang') === 'en') this.activeComponent = { component: 'settings-main', text: 'Main' }
  }
}
</script>

<style lang="stylus">
@import '../../assets/stylus/base/vars.styl';

.settings {
  display: block;

  @media (max-width: breakpoint-xl) {
    .inner-page__aside {
      display: block;
      max-width: 100%;
    }

    .inner-page__main {
      margin-right: 0;
    }
  }
}

.settings__title {
  font-family: font-exo;
  font-weight: 200;
  font-size: 30px;
  margin-bottom: 20px;
  color: #000;

  @media (max-width: breakpoint-xl) {
    display: none;
  }
}

.settings__wrap {
  display: flex;

  @media (max-width: breakpoint-xl) {
    flex-direction: column-reverse;
  }
}
</style>
