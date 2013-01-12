# jQuery Typewriter

For those who desire to bring the stunning visuals of PowerPoint 97 to the browser. jQuery Typewriter will present to you chunks of text, one painstaking letter at a time.


## Demo
See the [plugin page](http://albatrocity.github.com/jquery-typewriter/) for a demo and example uses.

## Dependencies
* [jQuery](http://jquery.com/)

# Usage

**HTML**

```html
  <p class='type-me'>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.</p>
```

**Javascript**

```javascript
  // Default auto-type
  $('.type-me').typewriter();

  // or pass in options
  $('.type-me').typewriter({
    auto: false,
    interval: 100,
    caret: {
      visible: true,
      blink: true,
      interval: 1000
    },
    onLetter: function(letter) {
      console.log(letter);
    },
    onComplete: function($typed) {
      $typed.css('background', 'blue');
    }
  });
```

The `auto` option will automatically start typing the text. If you have `auto` set to false, the Typwriter will be initiated, text will be hidden, and the caret will be inserted (unless you set `caret.visible` to false).

To start typing an instantiated Typewriter, run `typewriter('type')` on it.

```javascript
  $(".wait[data-speed='fast']").typewriter({
    auto: false,
    interval: 300
  });

  $(".wait[data-speed='slow']").typewriter({
    auto: false,
    interval: 1000
  });

  $('.stop-waiting').click(function() {
    $(".wait").typewriter('type');
  });  
```

### Options

<table>
  <tr>
    <td><code>auto</code></td>
    <td>start typing once instantiated</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>interval</code></td>
    <td>time in ms between each letter</td>
    <td><code>80</code></td>
  </tr>
  <tr>
    <td><code>caret</code></td>
    <td>object of options for caret</td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td><code>visible</code></td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td></td>
    <td><code>blink</code></td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td></td>
    <td><code>interval</code></td>
    <td><code>500</code></td>
  </tr>
  <tr>
    <td><code>onLetter(letter)</code></td>
    <td>function to be executed after each letter</td>
    <td></td>
  </tr>
  <tr>
    <td><code>onComplete($el)</code></td>
    <td>function to be executed after typing is done</td>
    <td></td>
  </tr>  
</table>


### Global Events

`typingComplete`

Example:  

```javascript
  $(window).on('typingComplete', function(e, el) {
    $(el).css('background', 'blue');
  });
```
