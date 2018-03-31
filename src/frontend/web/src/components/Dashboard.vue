<template>
  <b-container class="dashboard">
    <b-row>
        <b-col>
          @todo users goes here
          <texts></texts>
        </b-col>
        <b-col>@todo current text goes here</b-col>
        <b-col>@todo recommended texts goes here</b-col>
    </b-row>
  </b-container>
</template>

<script>
import Texts from './Texts'
export default {
  name: 'Dashboard',
  data () {
    return {

    }
  },
  components: {
    'texts': Texts
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
