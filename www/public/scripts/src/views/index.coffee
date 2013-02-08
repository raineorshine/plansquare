client.views.index = Backbone.View.extend

  build: ->
    that = this
    thisYear = Date.today().getFullYear()

    ['#page-index', [
      ['.container', [
        # ['heading.cf', [
          # ['h1#owner', 'Raine'],
        # ]],

        ['.events', _.range(thisYear, thisYear + 5).map (year) ->
          new client.partials.Year
            model: new Backbone.Model
              year: year
              events: that.model.get('events')
        ]
      ]]
    ]]

client.partials.Year = Backbone.View.extend
  build: ->
    that = this
    thisYearsEvents = this.model.get('events').filter (event) ->
      Date.parse(event.start).getFullYear() is that.model.get('year')

    ['.year', _.range(12).map (month) ->
      new client.partials.Month
        model: new Backbone.Model
          month: month
          events: thisYearsEvents
    ]

client.partials.Month = Backbone.View.extend
  tagName: 'span'
  build: ->
    that = this
    thisMonthsEvents = this.model.get('events').filter (event) ->
      Date.parse(event.start).getMonth() is that.model.get('month')

    ['.month', thisMonthsEvents.map (event) ->
      new client.partials.Event
        model: new Backbone.Model event
    ]

client.partials.Event = Backbone.View.extend
  build: ->
    startDate = Date.parse this.model.get('start')
    endDate = Date.parse this.model.get('end')
    endOfMonth = startDate.clone().moveToLastDayOfMonth()
    days = new TimeSpan(endDate - startDate).days + 1
    left = (startDate.getDate()-1) / endOfMonth.getDate() * 100
    width = days / endOfMonth.getDate() * 100
    # console.log this.model.get('title'), this.model.get('start'), this.model.get('end'), days

    typeClass = 'event-type-' + this.model.get('type').toLowerCase().replace(' ', '-')
    pastClass = if Date.today().compareTo(endDate) > 0 then 'past' else ''
    cssClass = typeClass + ' ' + pastClass

    title = if this.model.has('cost')
      '{0} (${1})'.supplant([this.model.get('title'), this.model.get('cost')])
    else
      this.model.get('title')

    ['.event', 'class': cssClass, style: 'margin-left: {0}%; width: {1}%'.supplant [left, width], [
      ['.details', [
        ['.title', title],
        ['.date', '{0} to {1}'.supplant [this.model.get('start'), this.model.get('end')] ]
      ]]
    ]]
