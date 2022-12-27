import express from "express";
import { selectSql, updateSql } from "../database/sql";

const router = express.Router();

// 기존의 입력 값 불러오기
router.get("/student", async (req, res) => {
  const stu_res = await selectSql.getStudent();
  res.render("updateStudent", {
    title: "학생 테이블 갱신",
    stu_res,
  });
});

// 수정 버튼을 눌렀을 경우 update query를 실행하며 조회 페이지로 이동
router.post("/student", async (req, res) => {
  const vars = req.body;
  const data = {
    Id: vars.id,
    Name: vars.name,
    Email: vars.email,
    Phone_number: vars.phone_number,
    Major: vars.major,
    Student_Id: vars.student_id,
    Did: vars.did,
  };
  await updateSql.updateStudent(data);

  res.redirect("/select");
});

module.exports = router;
