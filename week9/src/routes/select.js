import express from "express";
import { selectSql } from "../database/sql";

const router = express.Router();

router.get("/", async function (req, res) {
  const building = await selectSql.getBuilding();
  const classes = await selectSql.getClass();
  const club = await selectSql.getClub();
  const department = await selectSql.getDepartment();
  const employee = await selectSql.getEmployee();
  const join_clubs = await selectSql.getJoin_clubs();
  const room = await selectSql.getRoom();
  const student = await selectSql.getStudent();
  const take_classes = await selectSql.getTake_classes();

  res.render("select", {
    title1: "건물 테이블",
    title2: "수업 테이블",
    title3: "동아리 테이블",
    title4: "학과 테이블",
    title5: "직원 테이블",
    title6: "동아리 가입 테이블",
    title7: "방 테이블",
    title8: "학생 테이블",
    title9: "수업 수강 테이블",
    building,
    classes,
    club,
    department,
    employee,
    join_clubs,
    room,
    student,
    take_classes,
  });
});

module.exports = router;
