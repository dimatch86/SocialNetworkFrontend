<template lang="pug">
  ul.search-tabs
    li.search-tabs__item(v-for="(item,index) in tabs" :key="index" :class="{active: item.id === tabSelect}" @click="changeTab(item.id)") {{item.text}}
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'SearchTabs',
  computed: {
    ...mapGetters('global/search', ['tabs', 'tabSelect'])
  },
  mounted() {
    this.changeTab(this.tabSelect)
  },
  methods: {
    ...mapActions('global/search', ['changeTab'])
  }
}
</script>

<style lang="stylus">
@import '../../assets/stylus/base/vars.styl';

.search-tabs {
  display: flex;
  align-items: center;
  height: 55px;
}

.search-tabs__item {
  display: flex;
  height: 100%;
  padding: 0 10px;
  border-bottom: 4px solid transparent;
  color: #808080;
  align-items: center;
  font-size: 18px;
  cursor: pointer;

  &+& {
    margin-left: 50px;
  }

  &.active {
    color: eucalypt;
    border-bottom-color: eucalypt;
  }
}
</style>
