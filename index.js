const express = require('express');
const app = express();
const PORT = 3005;

app.get('/', (req, res) => {
    res.send('Hello, Geeks!');
});

app.listen(PORT, () => {
    console.log(`Server is listening at http://localhost:${PORT}`);
});