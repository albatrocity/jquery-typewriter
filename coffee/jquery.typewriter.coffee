# =========================================================
# * jquery.typewriter.js v2.2.2
# * http://albatrocity.github.com/
# * =========================================================
# * Copyright 2012 Ross Brown
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# * http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# * ========================================================= 


( ($) ->

  class Typewriter                            # class definition
    constructor: (i, el, settings) ->            # getting the settings object from below

      @settings = settings                    # make the settings that were passed in 
      @$el      = $(el)                       # available to the whole instance

      @text     = @settings.text || @$el.text() # use text from options or text of element

      @$el.data 'orig-text', @text            # set element's data-text attr to the text
      @text    = @$el.data 'orig-text'

      @$el.text ''                           # empty the element's text
      @letters = @text.split('')             # get an array of letters in text

      if @settings.caret.visible
        @caret = $("<span class='typewriter-caret-#{i}'>|</span>").appendTo(@$el)
        @caret.appendTo @$el
        if @settings.caret.blink
          hidden = false
          blink = setInterval (=>
            if hidden
              @caret.css 'opacity', 1
              hidden = false
            else
              @caret.css 'opacity', 0
              hidden = true
          ), @settings.caret.interval

    type: ->
      i = 0                                 # set a counter at 0
      typeLetter = setInterval (=>
        if i < @letters.length               
          @$el.append @letters[i]             # append the letter to the element
          if @settings.caret.visible
            @caret.appendTo @$el
          last_typed  = @letters[i]
          @settings.onLetter.call(@, last_typed)
          ++i                                # increment counter
        else
          clearInterval(typeLetter)                 # stop the interval execution
          @settings.onComplete.call(@, @$el)        # call the onComplete() function and pass it $el
          $(window).trigger 'typingComplete', @$el  # trigger the global typingComplete event
      ), @settings.interval                         # get interval from settings


  # Adds plugin object to jQuery
  $.fn.extend
    typewriter: (option) ->
      # Default settings
      settings =
        interval: 80
        text: undefined
        auto: true
        caret:
          visible: true
          blink: true
          interval: 500
        onLetter: (letter) ->
        onComplete: ($el) ->

      @each (i, el) ->
        data = $(el).data('typewriter')
        # If the option parameter was an object of options, extend the settings with it.
        # If it was blank, just use the default settings
        options = $.extend({}, settings, $(el).data(), typeof option is "object" and option)
        $(el).data "typewriter", (data = new Typewriter(i, el, options))  unless data
        if typeof option is "string"
          # If the option object was a string, execute the function on the instance 
          data[option]()
        else data.type() if options.auto
          # If no options are supplied, auto-run the type with default options

) jQuery