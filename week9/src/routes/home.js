import express from "express";
import { insertSql, selectSql } from "../database/sql";

const router = express.Router();

router.get("/", (req, res) => {
  res.render("home");
});

router.post("/", (req, res) => {
  const vars = req.body;
  const var_length = Object.keys(req.body).length;

  if (var_length > 5) {
    const data = {
      Id: vars.id,
      Name: vars.name,
      Email: vars.email,
      Phone_number: vars.phone_number,
      Major: vars.major,
      Student_Id: vars.student_id,
      Did: vars.did,
    };

    insertSql.setStudent(data);
  } else if (var_length > 2) {
    const data = {
      Id: vars.id,
      Name: vars.name,
      Capacity: vars.capacity,
      Bid: vars.bid,
      Did: vars.did,
    };

    insertSql.setRoom(data);
  } else {
    const data = {
      Id: vars.id,
      Name: vars.name,
    };

    insertSql.setBuilding(data);
  }

  res.redirect("/");
});

module.exports = router;
