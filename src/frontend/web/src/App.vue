<template>
  <div id="app">
    <h1>readus</h1>
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  border: solid 1px #3f2834;
  background: #fff2b4;
  color: #3f2834;
  width: 1000px;
  margin: 20px auto;
  padding: 10px;
  /*font-family: "Source Sans Pro", sans-serif;*/
}

h1 {
  /*font-family: "Lato", sans-serif;*/
  margin-top: 0;
}
</style>
