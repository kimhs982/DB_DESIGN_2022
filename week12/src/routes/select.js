/*
Copyright 2022 khs

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import express from "express";
import { selectSql, insertSql, deleteSql } from "../database/sql";

const router = express.Router();

router.get("/", async function (req, res) {
  const possibleClasses = await selectSql.getPossibleClasses(
    req.cookies.user_id
  );
  const takeClasses = await selectSql.getTakeClasses(req.cookies.user_id);
  const stuId = await selectSql.getStudentId(req.cookies.user_id);
  const depName = await selectSql.getDepartmentName(req.cookies.user_id);

  if (req.cookies.user && req.cookies.user_id) {
    res.render("select", {
      user: req.cookies.user,
      possibleClasses,
      takeClasses,
      stuId,
      depName,
    });
  } else {
    res.render("/");
  }
});

// 신청 버튼을 눌렀을 경우 insert query 또는 delete query를 실행함
router.post("/", async (req, res) => {
  let classId;
  let isInsert = false;
  if (req.body.delBtn === undefined) {
    classId = req.body.insBtn;
    isInsert = true;
  } else classId = req.body.delBtn;

  const data = {
    Sid: req.cookies.user_id,
    Cid: classId,
  };

  if (isInsert) await insertSql.setTakeClasses(data);
  else await deleteSql.deleteTakeClasses(data);

  res.redirect("/sugang");
});

module.exports = router;
