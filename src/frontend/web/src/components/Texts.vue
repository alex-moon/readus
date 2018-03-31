<template>
  <div class="texts">
    <h2>Texts</h2>
    <b-list-group>
      <b-list-group-item v-for="text in texts">{{ text.name }}</b-list-group-item>
    </b-list-group>
  </div>
</template>

<script>
export default {
  name: 'Texts',
  data () {
    return {
      'texts': [
        {'name': 'poo'},
        {'name': 'pee'}
      ]
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
