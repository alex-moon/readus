<template>
  <div class="texts">
    <h2>Texts</h2>
    <b-list-group>
      <b-list-group-item
        v-for="text in texts"
        :key="text.id"
        :uuid="text.uuid"
        :class="{ active: text.isActive }"
        v-on:click="onTextItemClicked"
      >{{ text.name }}</b-list-group-item>
    </b-list-group>
  </div>
</template>

<script>
export default {
  name: 'Texts',
  data () {
    return {
      'texts': [
        {
          'uuid': '140fd3da-abc8-46cb-8b90-dfe37ddbb03f',
          'name': 'poo',
          'isActive': false
        },
        {
          'uuid': 'bd5c4f7d-6a3b-49ba-8313-6f9043207d0a',
          'name': 'pee',
          'isActive': false
        }
      ]
    }
  },
  methods: {
    onTextItemClicked: function (event) {
      for (let text of this.$data.texts) {
        let uuid = event.currentTarget.getAttribute('uuid')
        if (text.uuid === uuid) {
          text.isActive = true
        } else {
          text.isActive = false
        }
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h2 {
    font-size: large;
  }
</style>
