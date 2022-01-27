---
layout: post
title: Password Generator
permalink: /pass/
content-type: static
---

<main>
    Length:&nbsp; <!-- TODO Correctly update slider value -->
    <input type="range" id="pwd-length" min="6" max="35" value="8" oninput="this.nextElementSibling.value = this.value">
    <output>8</output>
    <br/>

    <input type="checkbox" id="pwd-numbers" name="pwd-options" value="pwd-numbers" checked>
    <label for="pwd-numbers">Numbers</label>
    <br/>

    <input type="checkbox" id="pwd-uppercase" name="pwd-options" value="pwd-uppercase" checked>
    <label for="pwd-uppercase">Uppercase</label>
    <br/>

    <input type="checkbox" id="pwd-special" name="pwd-options" value="pwd-special">
    <label for="pwd-special">Special characters</label>
    <br/>

    <button onclick="generatePassword()">Generate</button>
    <button onclick="clearPasswords()">Clear</button>
    <br/><br/><hr style="background-color:var(--border);"><br/>

    <h3>Passwords</h3>
    <ul id="passwords"></ul>
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

function generatePassword(_len=undefined, _numbers=undefined, _uppercase=undefined, _special=undefined) {
    const length    = _len       !== undefined ? _len       : document.getElementById("pwd-length").value;
    const numbers   = _numbers   !== undefined ? _numbers   : document.getElementById("pwd-numbers").checked;
    const uppercase = _uppercase !== undefined ? _uppercase : document.getElementById("pwd-uppercase").checked;
    const special   = _special   !== undefined ? _special   : document.getElementById("pwd-special").checked;

    const consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'r', 's', 't', 'v', 'w', 'x', 'z'];
    const vowels     = ['a', 'e', 'i', 'o', 'u', 'y']; // y is subjectively objectively a vowel.
    const specials   = ['!', '@', '#', '$', '%', '*', '&', '*', '-', '+', '?'];

    let password = "";

    let passwordConsonants = "";
    for ( let i = 1; i <= Math.floor(length / 2); i++ ) {
        passwordConsonants += consonants[randint(consonants.length - 1)]
    }
    let passwordVowels = "";
    for ( let i = 1; i <= Math.ceil(length / 2); i++ ) {
        passwordVowels += vowels[randint(vowels.length - 1)]
    }
    // Merge every other consonant / vowel (this is a hacky way to do it lol)
    const merge = (a, b) => a.length ? [a[0], ...merge(b, a.slice(1))] : b;
    password += merge(passwordConsonants, passwordVowels).join('');

    // Prepend
    if ( uppercase ) password = password.charAt(0).toUpperCase() + password.slice(1);

    // Append
    let append = "";
    if ( special ) append += specials[randint(specials.length - 1)];
    if ( numbers ) append += randint(10, 99).toString();

    if ( append ) password = password.slice(0, -append.toString().length) + append.toString();

    const passwordUl = document.getElementById("passwords");
    passwordUl.innerHTML += "<li>" + password + "</li>";
}
</script>
