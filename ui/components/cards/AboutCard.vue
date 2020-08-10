<template>
  <div>
    <Card class="p-mt-6 p-mx-6 p-shadow-4">
      <template slot="title">
        A New Lottery Era!
      </template>
      <template slot="content">
        Colorado Lottery is excited to introduce Lotto Buffalo! Lotto Buffalo is
        an exciting monitor game built on top of the Ethereum blockchain
        allowing Colorado to take your gaming and our community to the next
        level.
      </template>
    </Card>
    <Card class="p-mt-6 p-mx-6 p-shadow-4">
      <template slot="title">
        Exclusive Items!
      </template>
      <template slot="content">
        Every time you enter a Lotto Buffalo contest you have a chance of also
        randomly winning an exclusive digital item for your Buffalo, admission
        tickets to one of the many parks Colorado Lottery helps benefit, or an
        item from one of our many sponsors! All items are tracked on the
        blockchain and can be sold through Colorado Lottery's item exchange.
      </template>
    </Card>
  </div>
</template>
<script>
import Card from 'primevue/card';

export default {
    components: {
        Card
    }
}
</script>
