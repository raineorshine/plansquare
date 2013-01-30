client.views.index = Backbone.View.extend

  build: ->
    that = this

    # get next 8 months
    nextMonths = RJS.range(0, 11).map (n) ->
      Date.today().moveToFirstDayOfMonth().add month: n

    ['#page-index', [
      ['.container', [
        ['heading.cf', [
          ['h1#owner', 'Raine'],
          ['h2#year', '2013'],
        ]],
        ['.events', nextMonths.map (month) ->
          new client.partials.Month
            model: new Backbone.Model
              month: month
              events: that.model.get('events')
        ]
      ]]
    ]]

client.partials.Month = Backbone.View.extend
  tagName: 'span'
  build: ->
    that = this
    thisMonthsEvents = this.model.get('events').filter (event) ->
      Date.parse(event.start).getMonth() is that.model.get('month').getMonth()

    ['.month', thisMonthsEvents.map (event) ->
      new client.partials.Event
        model: new Backbone.Model event
    ]

client.partials.Event = Backbone.View.extend
  build: ->
    startDate = Date.parse this.model.get('start')
    endDate = Date.parse this.model.get('end')
    endOfMonth = startDate.clone().moveToLastDayOfMonth()
    left = startDate.getDate() / endOfMonth.getDate() * 100
    width = (endDate.getDate() - startDate.getDate()) / endOfMonth.getDate() * 100

    ['.event', style: 'margin-left: {0}%; width: {1}%'.supplant [left, width], [
      ['.details', [
        ['.title', this.model.get('title')],
        ['.date', '{0} to {1}'.supplant [this.model.get('start'), this.model.get('end')] ]
      ]]
    ]]
