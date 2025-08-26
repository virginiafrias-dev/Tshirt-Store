import { prisma } from "./prisma/prisma";

const express = require("express");
const PORT = 3030;
const app = express();

app.get("/", (req, res) => {
  res.send(`Bienvenido a Tshirt-Store, corriendo en el puerto ${PORT}`);
});

app.listen(PORT || 3000, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
