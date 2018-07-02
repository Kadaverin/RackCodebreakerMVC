
function validateUserGuessInput(){
    return validateInputByRegexp("user-guess-input" ,  /^[1-6]{4}$/)
}

function validateUserNameInput(){
    return validateInputByRegexp("user-name-input", /^[A-ZА-Я1-9]{1,}$/i)
}

function validateInputByRegexp(id , regexp){
    let input = document.getElementById(id)
    let target = input.value.trim()
    isCorrect = regexp.test(target)
    if (!isCorrect) { input.classList.add('is-invalid')}
    return isCorrect
}