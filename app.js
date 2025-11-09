const express = require('express');
const app = express();
const port = 3000;

// Route בסיסי
app.get('/', (req, res) => {
  res.send('Hello World!');
});

// הפעלת השרת
app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
