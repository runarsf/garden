---
layout: post
title: Password Generator
content-type: post
---
<!-- TODO Passphrase -->

<main>
  <!-- TODO Cookies -->
  <!-- TODO Correctly update slider value -->
  <label for="pwd-length">Length</label>
  <input type="range" id="pwd-length" min="6" max="35" value="8" oninput="this.nextElementSibling.value = this.value">
  <output>8</output>
  <br/>

  <input type="checkbox" id="pwd-numbers" name="pwd-options" value="pwd-numbers" checked>
  <label for="pwd-numbers">Numbers</label>
  <span class="noselect">&mdash;</span>
  <label for="pwd-numbers-pos">Position:</label>
  <select name="pwd-numbers-pos" id="pwd-numbers-pos">
    <option value="end">End</option>
    <option value="random">Random</option>
  </select>
  <!-- TODO Multiple numbers randomly placed -->
  <br/>

  <input type="checkbox" id="pwd-uppercase" name="pwd-options" value="pwd-uppercase" checked>
  <label for="pwd-uppercase">Uppercase</label>
  <span class="noselect">&mdash;</span>
  <label for="pwd-uppercase-pos">Position:</label>
  <select name="pwd-uppercase-pos" id="pwd-uppercase-pos">
    <option value="beginning">Beginning</option>
    <option value="random">Random</option>
  </select>
  <!-- TODO Amount -->
  <br/>

  <input type="checkbox" id="pwd-special" name="pwd-options" value="pwd-special">
  <label for="pwd-special">Special characters</label>
  <span class="noselect">&mdash;</span>
  <label for="pwd-special-pos">Position:</label>
  <select name="pwd-special-pos" id="pwd-special-pos">
    <option value="end-pre">End, before numbers</option>
    <option value="end-post">End, after numbers</option>
    <option value="random">Random</option>
  </select>
  <!-- TODO Amount -->
  <br/>

  <input type="checkbox" id="pwd-readable" name="pwd-options" value="pwd-readable" checked>
  <label for="pwd-readable">Human readable</label>
  <br/>

  <button onclick="generatePassword()">Generate</button>
  <button onclick="clearPasswords()">Clear</button>
  <br/><br/><!--<hr style="background-color:var(--border);"><br/>-->

  <u style="color:var(--border);"><h3 style="color:var(--text-main);">Passwords</h3></u>
  <ul id="passwords"></ul>
  <!-- TODO Wrap -->
</main>

<script>
function clearPasswords() {
  const passwordUl = document.getElementById("passwords");
  passwordUl.innerHTML = "";
}

const randint = (_min=undefined, _max=undefined) => {
  const min =  Math.ceil((!_min && !_max) ? 10 : !_max ? 0    : _min);
  const max = Math.floor((!_min && !_max) ? 99 : !_max ? _min : _max);

  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// const replaceAt = function(_string, index, replacement) {
//   return _string.substr(0, index) + replacement + _string.substr(index + replacement.length);
// }
String.prototype.replaceAt = function(index, replacement) {
    return this.substr(0, index) + replacement + this.substr(index + replacement.length);
}

function generatePassword(
    _len          = null,
    _numbers      = null,
    _numbersPos   = null,
    _uppercase    = null,
    _uppercasePos = null,
    _special      = null,
    _specialPos   = null,
    _readable     = null,
  ) {
  const options = {
    length       : _len          ?? document.getElementById("pwd-length").value,
    numbers      : _numbers      ?? document.getElementById("pwd-numbers").checked,
    numbersPos   : _numbersPos   ?? document.getElementById("pwd-numbers-pos").value,
    uppercase    : _uppercase    ?? document.getElementById("pwd-uppercase").checked,
    uppercasePos : _uppercasePos ?? document.getElementById("pwd-uppercase-pos").value,
    special      : _special      ?? document.getElementById("pwd-special").checked,
    specialPos   : _specialPos   ?? document.getElementById("pwd-special-pos").value,
    readable     : _readable     ?? document.getElementById("pwd-readable").checked,
  }

  const consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'r', 's', 't', 'v', 'w', 'x', 'z'];
  const vowels     = ['a', 'e', 'i', 'o', 'u', 'y']; // y is subjectively objectively a vowel.
  const specials   = ['!', '@', '#', '$', '%', '*', '&', '*', '-', '+', '?'];

  let password = "";

  if ( options.readable ) {
    let passwordConsonants = "";
    for ( let i = 1; i <= Math.ceil(options.length / 2); i++ ) {
      passwordConsonants += consonants[randint(consonants.length - 1)];
    }
    let passwordVowels = "";
    for ( let i = 1; i <= Math.floor(options.length / 2); i++ ) {
      passwordVowels += vowels[randint(vowels.length - 1)];
    }
    // Merge every other consonant / vowel (this is a hacky way to do it lol)
    const merge = (a, b) => a.length ? [a[0], ...merge(b, a.slice(1))] : b;
    password += merge(passwordConsonants, passwordVowels).join('');
  } else {
    const letters = consonants.concat(vowels);
    for ( let i = 1; i <= options.length; i++ ) {
      password += letters[randint(letters.length - 1)];
    }
  }

  let append = "";
  if ( options.numbers ) {
    const _number = randint(0, 99).toString()
    if ( options.numbersPos === "random" ) password = password.replaceAt(randint(password.length-1-append.length), _number)
    else                                    append += _number;
  }
  if ( options.special ) {
    const _special = specials[randint(specials.length - 1)].toString();
    if      ( options.specialPos === "end-pre" ) append   = _special + append;
    else if ( options.specialPos === "random"  ) password = password.replaceAt(randint(password.length-1-append.length), _special)
    else                                         append  += _special;
  }

  if ( options.uppercase ) {
    const _upperize = randint(password.length-1-append.length)
    if ( options.uppercasePos === "random" ) password = password.replaceAt(_upperize, password.charAt(_upperize).toUpperCase())
    else                                     password = password.replaceAt(0, password.charAt(0).toUpperCase())
  }

  if ( append ) password = password.slice(0, -append.toString().length) + append.toString();

  const passwordUl = document.getElementById("passwords");
  if ( password ) passwordUl.innerHTML += "<li>" + password + "</li>";
}
</script>
