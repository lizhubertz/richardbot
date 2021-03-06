# Dependencies
#   npm install mocha -g
#   npm install co
#   npm install chai
#   npm install coffee-script
#
# Run the tests
#   npm run test

Helper = require('hubot-test-helper')
expect = require('chai').expect
co = require('co')

# helper loads a specific script if it's a file
helper = new Helper('./../scripts/exercise.coffee')

describe 'hello', ->

  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  context 'when adding a user', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', 'hubot add me'
        yield @room.user.say 'bob',   'hubot hello'

    it 'user adds themselves', ->
      expect(@room.messages).to.eql [
        ['alice', 'hubot hello']
        ['hubot', 'hello alice']
        ['bob',   'hubot hello']
        ['hubot', 'hello bob']
      ]

  context 'user says where is everybody', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', 'where is everybody?'

    it 'should reply to user', ->
      expect(@room.messages).to.eql [
        ['alice', 'where is everybody?']
        ['hubot', "@channel, I'm here!"]
      ]
