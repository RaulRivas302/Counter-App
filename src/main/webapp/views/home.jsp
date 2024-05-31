<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        html, body {
            height: 100vh;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(to right, #99004d 50%, #0000FF 100%);
        }

        .container {
            background: #fff;
            max-width: 500px;
            width: 100%;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .container h1 {
            font-size: 30px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
        }

        .container h2 {
            font-size: 20px;
            font-weight: 500;
            margin: 20px 0;
            color: #555;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .button-group button {
            background: #4070f4;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .button-group button:hover {
            background: #0e4bf1;
        }

        .logout-button {
            background: #ff4d4d;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 20px;
        }

        .logout-button:hover {
            background: #e60000;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Home Page</h1>
        <h2>Welcome, <span id="userName"></span>!</h2>
        <h2>Counter: <span id="counter"></span></h2>
        <div class="button-group">
            <button onclick="decrementCounter()">-</button>
            <button onclick="incrementCounter()">+</button>
        </div>
        <form action="Logout" method="post">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </div>

    <script>
        var currentUrl = window.location.href;

        console.log(currentUrl);

        var urlParams = new URLSearchParams(window.location.search);
        var userName = urlParams.get('userName');
        var counter = parseInt(urlParams.get('counter'));

        document.getElementById('userName').textContent = userName;
        document.getElementById('counter').textContent = counter;

        function incrementCounter() {
            counter++;
            document.getElementById('counter').textContent = counter;
            updateCounterOnServer(counter);
        }

        function decrementCounter() {
            counter--;
            document.getElementById('counter').textContent = counter;
            updateCounterOnServer(counter);
        }

        function updateCounterOnServer(counter) {
            fetch('/updateCounter', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ uname: userName, counter: counter })
            })
                .then(response => response.text())
                .then(data => console.log(data))
                .catch(error => console.error('Error:', error));
        }
    </script>
</body>
</html>
