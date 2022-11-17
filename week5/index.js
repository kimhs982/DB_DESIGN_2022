import express from "express";
import bodyParser from "body-parser";
import path from "path";
import sql from "./sql";

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", async (req, res) => {
  await sql.insertEmployee();
  const employee = await sql.getEmployee();
  // console.log(employee);
  // res.sendFile(path.join(__dirname + "/index.html"));
  res.json({ Employee: employee });
});

app.listen(3000, () => {
  console.log("Server is running on port 3000.");
});
