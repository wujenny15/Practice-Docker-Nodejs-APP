const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("Hello, this is Jenny here");
});

app.listen(8080, () => {
  console.log("Listening on port 8080");
});

