<template>
  <div>
    <Button type='primary' @click='getdata'>ok</Button>
    <Button type="primary" @click="exportData">导出</Button>
    <Table :columns='columns1' :data='docdata' ref="table"></Table>
    <div class=''>
      <!-- {{docdata}} -->
    </div>
  </div>
</template>

<script>
  var path = require('path')
  var fs = require('fs')
  var _path = path.join(__dirname, '..', 'game/dota/data/clientData/Battle.json')

  export default {
    name: 'landing-page',
    components: {
    },
    data () {
      return {
        columns1: [
          {
            title: 'ID',
            width: 200,
            fixed: 'left',
            key: 'ID'
          },
          {
            title: 'LevelID',
            width: 200,
            key: 'LevelID'
          },
          {
            title: 'BackgroundPic',
            width: 200,
            key: 'BackgroundPic'
          },
          {
            title: 'BossDPS%',
            width: 200,
            key: 'BossDPS%'
          },
          {
            title: 'Level5',
            width: 200,
            key: 'Level5'
          },
          {
            title: 'MoneyReward1',
            width: 200,
            key: 'MoneyReward1'
          },
          {
            title: 'MoneyReward2',
            width: 200,
            key: 'MoneyReward2'
          },
          {
            title: 'MoneyReward3',
            width: 200,
            key: 'MoneyReward3'
          },
          {
            title: 'MoneyReward4',
            width: 200,
            key: 'MoneyReward4'
          },
          {
            title: 'MoneyReward5',
            width: 200,
            key: 'MoneyReward5'
          },
          {
            title: 'Monster1ID',
            width: 200,
            key: 'Monster1ID'
          },
          {
            title: 'Monster2ID',
            width: 200,
            key: 'Monster2ID'
          },
          {
            title: 'Monster3ID',
            width: 200,
            key: 'Monster3ID'
          },
          {
            title: 'Monster4ID',
            width: 200,
            key: 'Monster4ID'
          },
          {
            title: 'Monster5ID',
            width: 200,
            key: 'Monster5ID'
          },
          {
            title: 'MonsterDPS%',
            width: 200,
            key: 'MonsterDPS%'
          },
          {
            title: 'MonsterHP%',
            width: 200,
            key: 'MonsterHP%'
          },
          {
            title: 'MP1',
            width: 200,
            key: 'MP1'
          },
          {
            title: 'MP2',
            width: 200,
            key: 'MP2'
          },
          {
            title: 'MP3',
            width: 200,
            key: 'MP3'
          },
          {
            title: 'MP4',
            width: 200,
            key: 'MP4'
          },
          {
            title: 'MP5',
            width: 200,
            key: 'MP5'
          },
          {
            title: 'RaidWaveWeight',
            width: 200,
            key: 'RaidWaveWeight'
          },
          {
            title: 'StageDifficulty:',
            width: 200,
            key: 'StageDifficulty:'
          },
          {
            title: 'StageID',
            width: 200,
            key: 'StageID'
          },
          {
            title: 'StageName',
            width: 200,
            key: 'StageName'
          },
          {
            title: 'Stars1',
            width: 200,
            key: 'Stars1'
          },
          {
            title: 'Stars2',
            width: 200,
            key: 'Stars2'
          },
          {
            title: 'Stars3',
            width: 200,
            key: 'Stars3'
          },
          {
            title: 'Stars4',
            width: 200,
            key: 'Stars4'
          },
          {
            title: 'Stars5',
            width: 200,
            key: 'Stars5'
          },
          {
            title: 'WaveID',
            width: 200,
            key: 'WaveID'
          }
        ],
        docdata: []
      }
    },
    methods: {
      getdata () {
        fs.readFile(_path, 'utf8', (err, data) => {
          if (err) {
            console.error(err)
          } else {
            console.log(data)
            this.docdata = JSON.parse(data)
          }
        })
      },
      exportData (type) {
        this.$refs.table.exportCsv({
          filename: 'The original data'
        })
      }
    }
  }
</script>

<style>

</style>
