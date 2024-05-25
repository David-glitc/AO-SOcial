document.getElementById('startButton').addEventListener('click', function() {
    fetch('/start')
        .then(response => response.text())
        .then(data => {
            console.log(data);
            document.getElementById('response').innerText = data;
        });
});
